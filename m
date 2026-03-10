Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED165FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473718409A;
	Tue, 10 Mar 2026 14:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CYtmVqaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0315F83FDE; Tue, 10 Mar 2026 14:04:22 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AE183981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 14:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b942b36de08so662998566b.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773147859; x=1773752659; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3tJxoCfYVXaTG2tz81O1cMw7Gjt5taq/1UxXA40bBCs=;
 b=CYtmVqaqE17WdiC2TQK/3lP50daFwsVgyuVO8B5+/o1GBUFOpGhMvEV2VUB194MFhi
 NSx7F6qXC0SEHn0WLYMX6IHN2F/xtFXx1Q07lmFtfm5rKAMcAA5m6YX39eR8dRkrLvZI
 25vJHuY7pSuwNeJehnZoESZVdLgg/pWPIcEzWuUd8EQRB1SNzS8b47VYhMQFSn7wh4wr
 Pon7cBmYQbS4bqY/y8BRuau6+5RqMSUlaehvmGxrhC2a8KJPmZbEmJZA8W0wX1mXXf+4
 KNbSq/pgB1xXnk1NILUN56SrygfYzTJeM7Rit7Ai7ASyMeCclidr/PcZy3QIFeS8edzg
 accg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147859; x=1773752659;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tJxoCfYVXaTG2tz81O1cMw7Gjt5taq/1UxXA40bBCs=;
 b=AgDCmloA2i0cgSO+EjTvFYg5Nn1tK8umfu/KVIsCSs+54iEEIlxQ1FlHQ0HEhbs9iq
 GxoA7YpLXwbQ+yEh1N+g8sCIbrpf7cO1zaDTSHwmWtztIUhOGTsopUVeGfZFi52yDp7L
 3gRgbX9SjQiq2ZDlW3aEPW3IPEguOw4n+1iAey1sGW0jF45VT79e1lJlHqQyH+Vln7yr
 Y3K/EyVoim6r4tVEqHIGf5bvX43+yzZGFz7cxWEEryirvOxMAn2fGcVdrvAJdd7G31+h
 1rPEZNxTK1hr0WM/vavkhk1W+eX5dmuMZ9o0wKzzhbs8T9ezD+h6y99iiY32qskwaNCK
 /LzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5xZoSe/EfLYpCUC/Ax2eaF+n+cTFaMKlvW0WTz92WhRgQ9szh5VGfg/Rt9IWRTYBYOm+mCnk=@lists.denx.de
X-Gm-Message-State: AOJu0YwRVnStR/QBP3pgocQn1+N/13IFI7Odp6d1G7EaP3WCTYdCZRD2
 c6cuBxk2e58f1hHkjA9GZVzNLOPiwSuiipPr0M9+Gc3n68du4dD3yOPN19A+1q+++yE=
X-Gm-Gg: ATEYQzx4TSLJ6dIcSy4B4EBavEbeeBr4mRXsi8d5hfcxXwYN0t6GKI/G0wKRNKw6HHq
 ITEuoSsYiWPYnAUM7uDpxCAv+lDWeb2lscCfj4I6p9toPsxisF9p4/ux63O8qjk49TtMJvqEez5
 T8xpcYt0s78OydQgLYgDgXbi2SlgbVCdboszW0bTBeElaXrC69cjbK9T0hMKLu8i7T+aX91rfiY
 l3tCl+2fHDYBIDXgczTFBwny/kJcQiQJHzt7+wKi9ZqtatkV1fspo8bnDUMJf4sEKvW3hT3Yskz
 Kojw/VoXy9z7I6oqLVorBDpCIa0fjKgU7/YoW414IAbRNJJ6ylUGAw7RBRGrSs/BpEPeIn+WTA7
 rZWrFgVc8b/dDL1Kq+FxHNSH2CVZkE3Wuxl3b7WacPCATMo/rxMELupOqV49hOSoHrRW9hcZPaf
 udslJuErYoofxW0SjFd/e233rokzOsgIoe9cYaMvMVKoIzXueHELpJ83QKxiKIVa5C1Tvn6QRLa
 l8l
X-Received: by 2002:a17:906:7309:b0:b96:f02b:3d5a with SMTP id
 a640c23a62f3a-b9711a1b2cbmr208082466b.16.1773147858284; 
 Tue, 10 Mar 2026 06:04:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:4d81:e92:c4c0:3c45?
 ([2a01:e0a:106d:1080:4d81:e92:c4c0:3c45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8daf2sm37136367f8f.2.2026.03.10.06.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 06:04:17 -0700 (PDT)
Message-ID: <a7a6e9e9-065b-460c-91d9-316ddfc4eb79@linaro.org>
Date: Tue, 10 Mar 2026 14:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:26 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 3/10/26 09:44, Alexey Charkov wrote:
> On Tue, Jan 20, 2026 at 10:09 PM Alexey Charkov <alchark@gmail.com> wrote:
>>
>> Rockchip RK3576 can load its bootloader from UFS among other options,
>> so this series adds the necessary bits and pieces to enable an end-to-end
>> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
>>
>> To achieve the above, this series goes through the following:
>>   - Patch 1 introduces arch-independent code to enable SPL images to use
>>     UFS devices, including build system tweaks and a function to locate
>>     a U-boot image at a fixed UFS offset and LUN (SCSI device number)
>>   - Patch 2 adds an option to build the Rockchip reset driver for SPL
>>   - Patch 3 adds device-reset functionality to the Rockchip UFS glue code,
>>     which is required for (at least some) UFS modules to respond to
>>     controller commands upon initial enumeration
>>   - Patch 4 ties it all together for Rockchip RK3576
>>
>> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
>> BWU3AKC46C256G UFS module. Note that booting directly from UFS masks the
>> issue which patch 3 aims to address, because the boot ROM initializes the
>> UFS module before handing over to U-boot. If, however, one boots SPL from
>> FSPI1 with the same driver code, the module fails to respond unless patch
>> 3 is applied.
>>
>> This depends on Jonas' recent series [3] enabling DMA writes to PMU SRAM,
>> without which the UFS controller will fail to load ATF and end up in an
>> unrecoverable error state requiring a hard reset.
>>
>> Note that in my experience none of the RK3576 boards actually boot current
>> mainline U-boot versions without a single-word SRAM write before jumping
>> to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, to
>> test this series I additionally applied commits 6b152999908b..d43031c4045e
>> from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any testers
>> might want to:
>>
>> git cherry-pick 6b152999908b^..d43031c4045e
>>
>> from there before or after applying this series
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/d43031c4045ef8aaf29c467b910207e721dabce0
>> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576?ref_type=heads
>> [3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.se/
>>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>> Changes in v5:
>> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
>> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
>>    This also pulls in SCSI to avoid compilation errors.
>> - Split out the patch enabling the Rockchip reset driver for SPL builds
>>    (thanks Quentin)
>> - Reworded the error message when requesting the UFS reset GPIO fails
>>    (thanks Quentin)
>> - Added a note in the commit message about reset-gpios being required by
>>    the DT binding (thanks Quentin)
>> - Dropped the redundant check of GPIO validity in the reset function
>>    (thanks Quentin)
>> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
>>    on RK3576 (thanks Shawn)
>> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
>>    and RESET drivers are explicitly depended on from the UFS driver
>>    (thanks Quentinq)
>> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com
>>
>> Changes in v4:
>> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
>>    writes to PMU SRAM (thanks Jonas)
>> - Dropped the bounce buffer quirk altogether, as it now works as-is
>> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com
>>
>> Changes in v3:
>> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
>>    SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
>> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
>> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com
>>
>> Changes in v2:
>> - Rename the SPL UFS read helper function more self-descriptively (thanks Neil)
>> - Add an option to configure the UFS LUN used to look for the U-boot image
>>    in raw offset mode - or rather the SCSI device number, which most of the
>>    time coincides with the UFS LUN as long as the UFS device is the only
>>    SCSI block device the SPL sees (thanks Neil)
>> - Add an option to use a bounce buffer in RAM while loading U-boot from UFS,
>>    which helps avoid changes to common spl_fit.c code which in v1 achieved a
>>    similar result at a performance cost to unrelated platforms (thanks Jonas)
>> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com
>>
>> ---
>> Alexey Charkov (4):
>>        spl: Make UFS available for SPL builds
>>        reset: rockchip: make device resets available in SPL
>>        ufs: rockchip: Add device reset support
>>        rockchip: spl: Add support for booting from UFS
>>
>>   MAINTAINERS                                  |  1 +
>>   arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
>>   arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>>   arch/arm/include/asm/spl.h                   |  1 +
>>   arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>>   arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
>>   common/spl/Kconfig                           | 30 +++++++++++++++++
>>   common/spl/Makefile                          |  1 +
>>   common/spl/spl_ufs.c                         | 49 ++++++++++++++++++++++++++++
>>   drivers/Makefile                             |  1 +
>>   drivers/reset/Kconfig                        |  9 +++++
>>   drivers/reset/Makefile                       |  2 +-
>>   drivers/scsi/Makefile                        |  3 ++
>>   drivers/ufs/Kconfig                          |  4 +++
>>   drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
>>   drivers/ufs/ufs-rockchip.h                   |  1 +
>>   lib/Makefile                                 |  1 +
>>   17 files changed, 155 insertions(+), 2 deletions(-)
>> ---
>> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
>> change-id: 20251210-rk3576-ufs-ac3bf4e87156
>> prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
>> prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
>> prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972
> 
> Hi Neil, Kever,
> 
> Now that Kever has applied the patch from Jonas [1] which lets this
> one work without bounce buffers on Rockchip RK3576, would you mind
> giving this series another look?

Applied patches 1 & 3 and passing it to CI, but seems without #2 UFS will probably
probe error so who is supposed to pick #2 ?

> 
> Please let me know if I should rebase / resubmit / adjust in any way.
> Would be great to have it merged.
> 
> Thanks a lot,
> Alexey
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/commit/4015faa32342fd9c494c318c21de106f98dd4674

