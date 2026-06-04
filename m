Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDACCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 06:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4806E8467E;
	Thu,  4 Jun 2026 08:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8aJ0Dmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E6984715; Thu,  4 Jun 2026 08:32:54 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A249844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 08:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso3574845e9.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780554771; x=1781159571; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3dObcurXw25P613YD49vWyar2rYGMp+vR3IggpmJhOQ=;
 b=f8aJ0Dmoj0brGqICaFlkC9DPsPE164zX1sbWlpDd6b5S2/DB0mglmdr19K8V5s5DMp
 D+moni7E9T38w0Et+w98HkgpbgLKXTqkZtBkVoFk+3GEPKngd6XGy8EV2bS1r32wdkJB
 99l99BwYisI+Q+JI+VjjH2NZEKUu3+Cv3RclIcZOsHp07nQKAOJQmQanG4omTbD+BdAV
 ZX0mvV7D2Wgs3vne0eTiJOSKgtQcJNw3RFPZOucauhw/2O3qojmc5X+s1/iEQo7TOcEB
 LabdrGuQ6EIdfOLDnLtpxth1knQw/uAvp0nx/IyjLUFxhTnP5811Xq5QaQPETLESnrdr
 Lx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780554771; x=1781159571;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dObcurXw25P613YD49vWyar2rYGMp+vR3IggpmJhOQ=;
 b=GSScb4PGtsG3qi2OInSUCgpb0+NraMPKFZdvrE+Ibf0zGfwXQfjWVesGK1BSySQu5a
 +HZtEEDMp2AcSeXFOH9WEOKHhfjJD48caXqLWIO1quDDseIDp3QurHJAkuNZ1IGcNzir
 UB9GCgP2Bhot7/tCZdvruUtk3pKkl55DIdagEW/JRK8JPlF6YHFkKJcm1cWAbLmB2MI2
 ybrqN350r39sBHgXq86NF4xXuZFmPznd8Pg25LChPzFjxgYJTYOjWWfI8b44J9AmSSEN
 9mJ0x0PCGDl94YOyRo0CZrFHw+fwL1nY64jDN6nKiNVUlGad7x9V0AIn2npECHcZnmU0
 H6nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BXDSeNWtoRxjngYer8OqrAsXCDZlp/1ZKgSA+z4LStN776RFdXAuLRXz5R9TycwWX8+pQD2k=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg3JZD9RgmX+OZ4Lpx1AVxjipU+9ITOraazNQwDRfZIWn4OGjk
 HGTimEiPqvaUNdXoLLrRm08iVyboSRdNUQX20DYY6jgi7U2slf6vOtFi9rFPkty4lZbxXLbzC2l
 2NbN/
X-Gm-Gg: Acq92OHVoNlVttkrx8jzKVNJYlpM0AdzlkAZ8FkYEUtE+eNuddui34gBc/LIOSy2AEr
 oaJO61dZvRXX1EsEnQ4ojntJg9A5eBrTDxLQQNifLVJ/45qZ1mZRukutaGgWmMIQ5pIrYyDnYQW
 F3sdmBuRmvl0DccphvkSRIeY3pAztkQp2+yKFW3gU8YKNK0yiirjyBoDN1N0GL+84H/R28+CwyA
 ZQPFkBSUUWVDmrQcLQ+2DOHR3nAm8s1xprAEaz4TYhMtwZl17Bdq2kdxNZm8mp4TtoYbWzKzWSG
 B7w+AYjWs/eoqix4w7QNG/Wf5t4Wj7W2RC6XukNF1HO4yfD7oq2uEVrhFMeDPQ+MVa4ZKhHEEjf
 H88M7ito17pfhXrueh19ZEQkbfX9M2O8tlzp4kdN0W5lncY/b4gB3xMS930wkKEEqahDgS98lP7
 PfdFbQospXgcx1UoN1fR8ZrxV52WRQueo14Do+YKqkLNjzMW5ssl7TE1wq38WAdmZYf1oMwGHGg
 LALvj+sACM3uOTIBA==
X-Received: by 2002:a05:600c:4748:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490b5ed6ad0mr103716335e9.13.1780554771424; 
 Wed, 03 Jun 2026 23:32:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2a0:317e:910e:9ac9?
 ([2a01:e0a:106d:1080:a2a0:317e:910e:9ac9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b59f0sm54281105e9.2.2026.06.03.23.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 23:32:51 -0700 (PDT)
Message-ID: <dbdc5f45-b4cd-4dae-8cf2-5e6172d5fc2d@linaro.org>
Date: Thu, 4 Jun 2026 08:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/6] nvme: few fixups
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260529034441.2075305-1-dmukhin@ford.com>
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
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/29/26 05:44, dmukhin@ford.com wrote:
> The series adds few fixes for NVMe subsystem.
> 
> Patch 1 adds logline for tracing misbehaving NVMe drives.
> Patch 2 adds plumbing for blk_flush()/blk_dflush().
> Patch 3 introduces NVMe flush command.
> Patch 4 enables `flush` for the currently selected block device.

As my thread on v1, please enable FUA or disable WC to be sure we don't use the WC.

Neil

> Patch 5 makes nvme_shutdown() symbol public to enable use of it from
>          board_quiesce_devices()
> Patch 6 tiny fixup for QEMU command for manual NVMe tests.
> 
> Denis Mukhin (6):
>    drivers: nvme: Log I/O timeouts
>    drivers: block: Introduce blk_flush()/blk_dflush()
>    drivers: nvme: Implement flush command
>    cmd: Add flush support for all blk devices
>    drivers: nvme: Export nvme_shutdown()
>    docs: nvme: Update QEMU command for testing
> 
>   cmd/blk_common.c                  | 14 ++++++++++++++
>   cmd/ide.c                         |  1 +
>   cmd/nvme.c                        |  1 +
>   cmd/pvblock.c                     |  1 +
>   cmd/sata.c                        |  1 +
>   cmd/scsi.c                        |  1 +
>   cmd/usb.c                         |  1 +
>   cmd/virtio.c                      |  1 +
>   disk/disk-uclass.c                |  6 ++++++
>   doc/develop/driver-model/nvme.rst |  2 +-
>   drivers/block/blk-uclass.c        | 18 ++++++++++++++++++
>   drivers/nvme/nvme.c               | 24 +++++++++++++++++++++++-
>   drivers/nvme/nvme.h               |  7 -------
>   include/blk.h                     | 28 ++++++++++++++++++++++++++++
>   include/nvme.h                    | 11 +++++++++++
>   include/part.h                    |  8 ++++++++
>   16 files changed, 116 insertions(+), 9 deletions(-)
> 

