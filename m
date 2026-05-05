Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B432DFF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46889849B2;
	Tue,  5 May 2026 19:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="bcZcjtRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2332984986; Tue,  5 May 2026 18:27:18 +0200 (CEST)
Received: from mxd-2-a03.seznam.cz (mxd-2-a03.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a03])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA2984974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 18:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-w7th8
 (smtpc-mxd-5f4d8d5f6f-w7th8 [2a02:598:64:8a00::1000:a03])
 id 67d65f513cd80b38667f930f; Tue, 05 May 2026 18:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1777998384; bh=5eohVBgaDIDYaP5rqjaAhKw3Ri8jlfInk8O58Z++mew=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=bcZcjtRbZjcT8bc51JXQ892GEHgCrZ7KhYpaihCsNK85jHXZX9tnv0FQw/C/lcwOa
 SARlq2/jtqUHUqBG9lq6u2yhm206TS+qGH0PQjxcBg8/bCj/g8H7m2UeA6QgNVTtMU
 BcCyBlbfWA8zKe+w/69/q4e/KwiGrSlQi4/Qb0gDwG6tHRdolw3JWsIlPMCCCdOCOl
 DlV/l95b1QkKQ1XCHTEdFX0oNvG5HwgWmwX3OI9IGNlwFsA/rej2tPaPhXS2Pn6tOh
 VxzCFF/tQECH/J+1ZmBdkZ90hfHOmJPKFMyea9Hx/FBFHFlVpkMFNMREh+IzT0NAvL
 1rvuA8RA+VfMg==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-7c7c659656-xkdqp (szn-email-smtpd/2.0.72) with ESMTPA
 id 8b10b3e6-318c-41ea-90bf-fb101111d5fb;
 Tue, 05 May 2026 18:26:21 +0200
Message-ID: <d7a881ec-5fbc-4d49-8115-c05911e81c1f@seznam.cz>
Date: Tue, 5 May 2026 18:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-1-11817415d664@seznam.cz>
 <CAFLszTj83hXz+mWj4jfJa6p5RY-yXCbpV0hrD2OFLgr0LPXz0w@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszTj83hXz+mWj4jfJa6p5RY-yXCbpV0hrD2OFLgr0LPXz0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 05 May 2026 19:58:20 +0200
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 5/5/26 15:58, Simon Glass wrote:
> Hi Michael,
>
> On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
>> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>>
>> Some platforms (e.g. at least Qualcomm) use the ELF format in creative
>> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
>> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
>> as the default).
>>
>> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>>
>> Makefile           |  9 +++++++--
>>   common/spl/Kconfig | 11 +++++++++++
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> @@ -238,6 +238,17 @@ config SPL_HANDOFF
>> +     help
>> +       This allows specifying a linker script that will be used to re-wrap
>> +       the SPL binary into an ELF.
>> +       Some platforms (e.g. at least Qualcomm) use the ELF format in creative
>> +       ways, including in the bootrom. For such platforms, you can change
>> +       the default linker script to a platform-specific one.
> Please add a blank line between the two paragraphs so menuconfig
> renders them separately.
>
> Missing file, as mentioned by Michal
looks like copy paste error, should clearly be arch/u-boot-elf.lds.
fwiw CI didn't complain, but I guess I should've compile tested
it locally.
> Regards,
> Simon

