Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26647C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 16:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F72829C3;
	Fri,  4 Apr 2025 18:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jPJ+LXI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EBD5829E7; Fri,  4 Apr 2025 18:10:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC5F829A0
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 18:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso11037895e9.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743783031; x=1744387831; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=riUn+rVqLE6xN8Jfu+WtJkGOUsGRaEpL4ObeXQR2I7E=;
 b=jPJ+LXI9qjyzK3aypdG+628rFLt+elfRgnTb/L9ER4kK04kDNSQCYT8G5r+jIuaBIj
 IhEm1Vacm/XrddQK91Pdbg67JWsuOqF+NhlLrij8ZcVlYmEGLdED0YUBuRN5FnpoTRt1
 E7raQCFklhz8LJ8E7VrIzI9qwKivg+uO66cnsJktOkgG6rOch/86G503TXUqx6sfICJ6
 a7kVtAU33Wndik+BazGIignTDgC4VD/HPCp0LZNM7uJT0h4dxTLj6Z3Dx8BGj3fBfpcu
 qeLQwUhETi4VM1oSQhjl9kV0e2ZJtdyGQBKFLEY5cMsLwek7GLYIOWmTXzSLhDQMltBj
 IhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743783031; x=1744387831;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=riUn+rVqLE6xN8Jfu+WtJkGOUsGRaEpL4ObeXQR2I7E=;
 b=v5fST3CGqQPEuf0zRDrqZi50o0oOws4OlxWkhYvaRlvBAampL0hK2kBasxWtiC2CeJ
 EmztXVcIJjWARajbp/ieWVfEfr3a2zSUAuqAymmKmt37M4ChSSjsLVsv9kgnvRZz8oDj
 ETCfRnerxcMC9wBfUG9GqvPkJjBGvo1ew2aDxJQxJIHMVyE2bLlmwme5FcMWfw6Hjm6Q
 gup9uhNep62j96FOqxRmRoMG9Lsz9R2P8MSCgqXoriODGvh4EC2HEy+yWfMdJZTALl8U
 6vjRWEI2s2psWc2HYwm3eWeNR7WojgY84Qy6rf7LEb/a/wZXL6wo6ddDsmeoG8ClNxpl
 0ayQ==
X-Gm-Message-State: AOJu0YyZmFNr/YYFsJOUadpL1h8wl4SMC5KeXP5lyENCC8D0FCZNmK6W
 o6v2ddjbZsXVu2Bz8qPhYiE7uGRNSOHGVe63Q1Y4nKxCb4bFnIrK5X8V9DYHk9rwk9sOKIi+i51
 d
X-Gm-Gg: ASbGnctPPzxvWvRQ4iapzmJdG1ZD1AqenoBkfuk+XB7Od0MUccnuIIcoCojthYimIgk
 MIs3oiL7WlfyZ0IB1Z0zxXeMsX8s8Mw1sERG2688aKi9gdXC1IdMPJ9H36J3SlNmLyGkvZfX35L
 OaM9m6z26eJVaLn8k7lJ6BPQKI/6Gy2S2uQbxhL6v4voMpYdfA+L2lhNdb4uK58XK5VY1GRprKS
 T937PhAVaulPIR/Lo4BKDn+aI+W5+EfBdv20xXpwiUqX+gXQYAIeHCyhlktx+xBmERDrr6OBskI
 QGYEWWPeBNoSwKR91ImXWcnL5I4ucOfevd/2U69AG6C6PcIWuqNnv4qkLQ/IQzp+nNexEn9DZFA
 H+vPAeDPxIEQjhrJSXlPCwakMVLNoCQ==
X-Google-Smtp-Source: AGHT+IFf1mop+96SiqBGcQmSHuT0ycgEYZCwynCkDSX8Dm2EldLTcRJIX0CnfqGZdMlZKxGqMcqPZQ==
X-Received: by 2002:a05:6000:1787:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39cb3596ea9mr3576228f8f.17.1743783031243; 
 Fri, 04 Apr 2025 09:10:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:19b:8166:6e82:3840?
 ([2a01:e0a:3d9:2080:19b:8166:6e82:3840])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm50600835e9.3.2025.04.04.09.10.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 09:10:30 -0700 (PDT)
Message-ID: <d78576bb-9ff3-4a62-b7f1-34849f10bbd6@linaro.org>
Date: Fri, 4 Apr 2025 18:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: =?UTF-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Reve?=
 =?UTF-8?Q?rt_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
To: u-boot@lists.denx.de
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
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
In-Reply-To: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 31/03/2025 18:49, Christian Kohlschütter wrote:
> Hi all,
> 
> After upgrading some rather old U-Boot/IPXE setup on two aarch64 boards (Amlogic S922X-based ODROID N2+ and RK3399-based NanoPi R4S), I noticed strange errors in the initrd phase of my Linux kernel — usually something like "Illegal instruction" coming from "udhcpc", etc.
> 
> The setup I have boots iPXE from U-Boot (either stored on SD or SPI), which then loads a Linux kernel, two initrds and a dtb from the local network, and boots Alpine Linux.

Could you help me reproduce this setup ?

As I understood you chainload ipxe.efi in U-Boot, then you boo your own distro from local network.

If you can give me your instructions I can try to reproduce and fix the meson ethernet driver.

Thanks
Neil

> 
> I found that the busybox binary used in my initrd had an md5sum mismatch compared to what was expected. I ruled out network problems since checksums from within iPXE were correct.
> So some code, either U-Boot, iPXE, or the Linux kernel, were interfering with the busybox binary at runtime. Since a single binary is used for many commands, and the changes were not always in the same location, there was wide variety of how things could fail, and — many times — fail in way that did not prevent booting.
> 
> As a workaround, via iPXE, I added a "padding" initrd to be loaded first, containing an 8MB long zero-byte filled file named /.aaaaargh. If there were any modifications, the would hit the padding file, not the busybox binary.
> If there were modifications, the file would remain completely empty upon boot.
> 
> However, they weren't:
> Example dumps from two runs:
> 
> # hexdump  /.aaaaargh
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0044100 ffff ffff ffff 15dc f9c8 6f16 e188 0000
> 0044110 00a0 52b0 a01c 6d59 0000 0000 0000 0000
> 0044120 0000 0000 0000 0000 0000 0000 0000 0000
> 0044130 0000 0000 0000 0000 0000 0000 e1a8 6097
> 0044140 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0155840 0320 0040 0000 0000 0000 0000 0000 0000
> 0155850 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0800000
> 
> # hexdump /.aaaaargh
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 001f800 ffff ffff ffff 15dc f9c8 6f16 e188 0000
> 001f810 00a0 52b0 a01c 6d59 0000 0000 0000 0000
> 001f820 0000 0000 0000 0000 0000 0000 0000 0000
> 001f830 0000 0000 0000 0000 0000 0000 e1a8 6097
> 001f840 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0094f40 0320 0040 0000 0000 0000 0000 0000 0000
> 0094f50 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0800000
> 
> By git-bisect'ing the codebase I found that the following U-Boot commit must have triggered the bug:
> 
>> commit 06ef8089f876b6dabf56caba31a05c003f03c629 (HEAD)
>> Author: Simon Glass <sjg@chromium.org>
>> Date:   Sun Dec 31 08:25:55 2023 -0700
>>
>>      efi: Correct smbios-table installation
>>          At present this code allocates memory when writing the tables and
>>      then unnecessarily adds another memory map when installing it.
>>          Adjust the code to allocate the tables using the normal U-Boot
>>      mechanism. This avoids doing an EFI memory allocation early in
>>      U-Boot, which may use memory that would be overwritten by a
>>      'load' command, for example.
>>          Signed-off-by: Simon Glass <sjg@chromium.org>
>>
>>   lib/efi_loader/efi_smbios.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
>  From what I gather from the code, the use of "memalign" instead of "efi_allocate_pages" could be the reason for the observed memory corruption, but I'm no expert in this codebase.
> 
> For what it's worth, the commit can cleanly be reverted from a recent U-Boot HEAD, and indeed, the system boots fine afterwards.
> 
> I also once noticed that one time the memory corruption happened after the first few calls within initrd, so maybe it's a "free" corresponding to that memalign that is triggering this bug.
> Or, maybe it's all good from u-boot's side but iPXE needs to do something, I don't know. I'm just the messenger here...
> 
> I wonder what can be done other than reverting this change (or using a padding initrd during boot) ?
> 
> Thanks,
> Christian
> 

