Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A07FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE26584A52;
	Tue, 30 Jun 2026 14:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AQa8Gghp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0171484A4F; Tue, 30 Jun 2026 13:04:22 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D2B84A1F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 13:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so3471224f8f.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782817459; x=1783422259; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WGBrPDOrQ6d6gNHVIsttmNWz8YwQ4uyrWCV/TfhQpU=;
 b=AQa8Gghp9XEpSUYwRwadnfyv77hHUKQaBGb0l/4+PTDGU7j1x4Dd0bI9XVCxnNADg+
 WEMwaZBfQWJueMBZWNWbxeI7erRgv4Llb7XiWmpShDui/Mogwq3O+/s/+RTxl/1HH/7I
 N79Wx6TO0FGoSl8xBuTMyVDCvjTdXE2HNH41/jdIuWH7OS3Yv1QH3UxcKM00jeEEG1fy
 UtbkmaLx1BH0ntoLaEHIj8kZj2gyIfOCKE69ZHO7KJ3OGSQtsDS+F7kGQkNRUc+4ew+t
 mMMK3Gp4BHbEDNQONLb214NN1U0rUZrg3wPCKC3kqvrRs5o+7K7c8+OYFme6TNcIK1/6
 R9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782817459; x=1783422259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WGBrPDOrQ6d6gNHVIsttmNWz8YwQ4uyrWCV/TfhQpU=;
 b=OWdmLOtf6Kbgpc2G33UFWv87m9nDGi1LktYLyerUu4YVL9rGGZ/5Y1nGZMygUUBSa2
 sXejx+tR7ADOhFKKxL0mbZLi2O8QkMgfQ4rmgrFIKU2htL370u42xBhUHh/Plu8n9Z2P
 1HdXcp/4b1YSr7m93nP2zXduZQ5VV6shq7RQJs9FK3Sx46921eHaLvcRRBjYnsOQ9VwL
 gBDsAB1WQWVMe7xrHjSU/QO2ZeOKDf5PNxAWYeOfmRbNOWCTaa+3uYA6C/luTNPkcZWP
 kRBN5kuwR76TCLwZYHWVrWYx6WhSIDssSvamvbZThnTVmwPjp9RtBZ2STpUolcZVud/R
 iDFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoToXwbCkG0vHWPCeowdOnkcfgjEl00EYloLY1kQ8Cv4nLLzBG5d5AQbtd8WyE6VNviyIW9Y70=@lists.denx.de
X-Gm-Message-State: AOJu0YyaBusH0wfpsmX+GJ/z3iQlHZ2RCconQmCsY9BdajNomkjUyCZ7
 bPFt+2ZUoV2Gv10ThNUd/uOEXnTnxpUl3WNEKeNbWNWAV7Y7EpeLtnJX0sW4REruhVQ=
X-Gm-Gg: AfdE7cm8T9Cj7X0lA/SAyy6gtSzUyZKc8wqK8RsBPGmvpdoSDLkiMc6yQmCQhaFeLcY
 xCZFpYl/hc9anftO3d1X3gn8lA3Ka6mdecWnaRP5wtW2hXjJNR3jJqZvE1P3rj2OiA7nMyFO1pY
 SOpgbBW43plYI2MaE+MIW7opyiN+Z6l1hnxN9OJBQxgEWRhMQXnlodeBWPGKE6BkobGt+auZbdu
 ga/YibAE9lG1MHpQbumsgcBzwpmNIur6S0+ZxNyd2qTX+M6OpNBjyOLZtNj7y34n6OOrm2rMH1z
 W+KKcub9130o3anvM2sUvzmHIiMQtZ1ZVC5V3RBJdGejsbZXZ9/2iF/idjex4AKRwSNju65/umv
 UBGltBkSmQP76XlK6Rpqi+jqmmkwaPELtyPl6ns3KvfJ++GjjiDJCpEAc0nhZDpQPZYmI9d905W
 h4fGrecSRMMTYZhKgkGKXV1hrzMqs=
X-Received: by 2002:a05:6000:2211:b0:474:6a5b:8606 with SMTP id
 ffacd0b85a97d-47551c05dacmr4170344f8f.21.1782817459017; 
 Tue, 30 Jun 2026 04:04:19 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf1asm7111758f8f.18.2026.06.30.04.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 04:04:18 -0700 (PDT)
Message-ID: <1e32d195-bd01-4c16-b04e-4634634c2158@linaro.org>
Date: Tue, 30 Jun 2026 13:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build
 instructions
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTi+TayLxOGq0K3G57VPcV3b_-Gc6-rrwODgOPfHDq70fA@mail.gmail.com>
 <akN5q6/GL9Vx3BkL@hu-varada-blr.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <akN5q6/GL9Vx3BkL@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:13 +0200
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



On 6/30/26 10:09, Varadarajan Narayanan wrote:
> On Mon, Jun 29, 2026 at 10:16:24AM +0100, Simon Glass wrote:
>> Hi Varadarajan,
>>
>> On 2026-06-23T06:47:53, Varadarajan Narayanan
>> <varadarajan.narayanan@oss.qualcomm.com> wrote:
>>> doc: board/qualcomm: Update RDP build instructions
>>>
>>> Add details about the SPL & U-Boot proper build steps, converting to
>>> flashable images, source URLs for the needed binaries and scripts.
>>>
>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>>
>>> doc/board/qualcomm/rdp.rst | 98 +++++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 93 insertions(+), 5 deletions(-)
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>>> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
>>> @@ -42,17 +46,101 @@ on your device with::
>>> -     EDL.  A tool like bkerler's edl_ can be used for flashing with the
>>> +     EDL.  A tool like bkerler's edl can be used for flashing with the
>>
>> I just wondered why you drop the _ ?
> 
> Will fix and send v7.

Please actually build the html docs and check that the formatting is 
correct when you do. Sphinx warnings make CI fail

> 
> Thanks
> Varada

