Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70C7C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8017387771;
	Tue, 28 Nov 2023 17:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="alzcilOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25E587771; Tue, 28 Nov 2023 17:34:59 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADD3876DE
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332ca7f95e1so3989326f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701189297; x=1701794097; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vydeIe/4qFipjumZojThhXCa2zqmMnc6NmBPzpYfS2k=;
 b=alzcilOvYLekLYT/8WR50d/TxXifyTqokcUK003LwSb7tDbaqazaegeeUrvCaKJJU3
 gdu65mJ0BXRaCRia8ccaI/c5SUs7kUUAU69YqTzWhkspMcQ1rfyXD6FXKy9a3XaJuNlu
 9vOyTQyXs7ObvPKJYKPCuTaV0u5wsKhxLBVdCuno7yTn+3naoNvr937dWi7oUKXzQJfm
 JVx+NLovKTMX46eTCllpdWx9FYPSMhIq3Nj0W+D0RVZn3g4DRGv/VfiBYMLwBs4fRbRL
 mPhWC3ztsDskMat0gjALJ5X05grjqd3MiWTKRXTw39OtZjuvBjqfrQOhLDtlxNpdz0zd
 xspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189297; x=1701794097;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vydeIe/4qFipjumZojThhXCa2zqmMnc6NmBPzpYfS2k=;
 b=lRToPSB1vJIT9mbIvK4rGqPeNt9pcUmwc41idGyaM4StgypwEB19UiLDEAqAayxr7Q
 BwO8EPWwVfYtkTZQRN9F0RPnzsoNGWJbmck56Tt1Ray4XlbL1aiC2wbjUHTD0YG7s+0S
 IndMRu3iE3PpPSNYRT0EYRl1gs4+LLad3qsERMrAFnxBmx7fCUFLV/seF2cSjvFBQaZp
 xykZPSN4FB/ScllJNg4ClP+jxZipJ1f9oG+hpD+Ay8yitfhVl0FqJGkgec1t02UOllcb
 tM76C3KBKN5jpF9WvfNy/Mj6n/vNG15B9wVk59Y1PX9xczKW2UM17cmLPqiXSBPolNZI
 A/4g==
X-Gm-Message-State: AOJu0YxxvrTEnUdvwF/4v7WkAtVBANmETRfj+wdfuKRVfGinGBusU9oF
 qP1qJxb/AH6zaQgbZVKX20CrUg==
X-Google-Smtp-Source: AGHT+IEJGp5uri9YL564txIXqil+9KRDWTgGXo9ETC0mi/AsmPmbfG64/RQa3xqIsb291ri+8k3frQ==
X-Received: by 2002:a5d:6484:0:b0:333:145e:f529 with SMTP id
 o4-20020a5d6484000000b00333145ef529mr111253wri.33.1701189296921; 
 Tue, 28 Nov 2023 08:34:56 -0800 (PST)
Received: from [10.10.51.254] (lmontsouris-659-1-84-229.w80-11.abo.wanadoo.fr.
 [80.11.4.229]) by smtp.gmail.com with ESMTPSA id
 z12-20020a5d640c000000b00332cc7c3aaasm15559955wru.21.2023.11.28.08.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 08:34:56 -0800 (PST)
Message-ID: <f5a9872a-0cff-45c6-b0e6-a8caec9d5755@linaro.org>
Date: Tue, 28 Nov 2023 17:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATHv11 06/43] net/lwip: implement tftp cmd
Content-Language: en-US, fr
To: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-7-maxim.uvarov@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231127125726.3735-7-maxim.uvarov@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Maxim,

On 27/11/2023 13:56, Maxim Uvarov wrote:
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace tftp command with the LWIP variant while keeping the output and
> error messages identical.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>   include/net/lwip.h             |  13 ++++
>   net/lwip/Makefile              |   1 +
>   net/lwip/apps/tftp/Makefile    |   7 ++
>   net/lwip/apps/tftp/lwip-tftp.c | 132 +++++++++++++++++++++++++++++++++
>   4 files changed, 153 insertions(+)
>   create mode 100644 net/lwip/apps/tftp/Makefile
>   create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
> 

<snip>


With:
=======><==============================================
diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
index 7b384cecf8..1d1b7e8fa5 100644
--- a/net/lwip/apps/tftp/lwip-tftp.c
+++ b/net/lwip/apps/tftp/lwip-tftp.c
@@ -8,6 +8,8 @@
  #include <command.h>
  #include <console.h>
  #include <bootstage.h>
+#include <efi_loader.h>
+#include <mapmem.h>

  #include "tftp_client.h"
  #include "tftp_server.h"
@@ -17,6 +19,7 @@

  #include <net/ulwip.h>

+static char *filename;
  static ulong daddr;
  static ulong size;
  static unsigned int progress_print;
@@ -38,6 +41,12 @@ static void tftp_close(void *handle)
                 ulwip_exit(-1);
                 return;
         }
+
+       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
+               efi_set_bootdev("Net", "", filename,
+                               map_sysmem(daddr - size, 1),
+                               size);
+
         ulwip_exit(0);
  }

@@ -92,6 +101,7 @@ int ulwip_tftp(ulong addr, char *fname)

         size = 0;
         daddr = addr;
+       filename = fname;
         server_ip = env_get("serverip");
         if (!server_ip) {
                 log_err("error: serverip variable has to be set\n");
=================><======================================

Loading EFI works again, and you can drop patch 15.

Neil
