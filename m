Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13155E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 08:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C39C80295;
	Fri,  3 Jan 2025 09:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOsMbdAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4352080196; Fri,  3 Jan 2025 09:48:04 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63DD80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 09:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa692211331so2286177366b.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735894080; x=1736498880; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDdSEAhRqhbWtm9iV2VjkBM2+mbwqA8+3mkPwblm9e4=;
 b=oOsMbdAapnbRkflQNMxImD8NgWAw5I4n67Qax2jsTR7+XJRqNpm06OcDXm5V8Y9k2M
 DaLZPcgtyV7cZb9EoNDc2U/x4p0hrzl5jL9dH6hkZhdY2kmkh42+xqy+Meq+8XLOFsO9
 +AHc9/0BhA5LzeqM/gyUpXxoTz7vgO++jSoBmQGxbU1GVWMAgYAfL5oWpiheJO+gBN7K
 1+LL+fcTl6UEK97HX8gS5Vz5h6KQH2wt76q5g4AAZNL4QCJyTK4s3r+vB5PW+wi6GtrG
 uYYWFMHs0RwPAD+BYpkNGGt5FroiwBzhmDVIz1Kl7uvMW6lgHrMiFcZzw1QtSEvqBKlf
 9uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735894080; x=1736498880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hDdSEAhRqhbWtm9iV2VjkBM2+mbwqA8+3mkPwblm9e4=;
 b=U3BJ4InhsyUM2CySx9V0SZUSL89+r8N7Cdg6v95i+PhDAzkrlCfDGlttExlb5MMmsG
 CyXnT1CDDFeU+5heTTkOLe/banZZlkxHX+zWMpEGJVP3aZz0VkasZIYnadRa/zD4191q
 8fbdCBLo/tK8Pu9xkWWI2bzj67sJBH999k2W04zr/sfIuJlNg2/pE23t6ziFh2TKu6el
 RVJ4v8G2FVOYGwqmbGTvnEUSSSRZdOqkkQHgHTdir24AynPXOpKl0+iYZnemzhhp4G1k
 9QMx+CZ4LvK3XaoGZORihfVHQ+NvbKO8HA/21u/xRQfwbkH8H6OnnXXGXqgTLKQ2P9TK
 /XjQ==
X-Gm-Message-State: AOJu0YyZ9j+uomJnZEwwIPj77KGbWyRtX793hnM6dGbl6LsVZw76ph/0
 ffIRxpc+nJOcX2y/77+JS9AldWFeBkPctQ7Re3xEsMU/v0zKGegiaJk1ossU4+Q=
X-Gm-Gg: ASbGncsE6rcEZHR5NgOKJFPG6w0E/OeOOzLYxfoIq8TGPpTSnE7Cw3Kf9n2y06eOCvl
 Q2q/V5qNy0JqhubADxPRqp80wrcw2487Q3oN6t+nNWL1zERUoi7Zf+0yT0bECbbe4FWHLCwy0Ww
 lJjqP4wsPuiv7nLRhxRLZ9+tm3+J6xqH/g1P14X5ZXYR8KsGQcc0FQ00hDtkAV/sIY8IowX0ADx
 9c8tHFEWEGOPN61FY9VuazJHZe7sO/wXc4W3nRoc5ZiYMsRM1OFB+SRQa6aRDaXQZGlpW0RWO0A
 euylCXVQeLvPdewuavPqHr57sKhbpwx3Gw==
X-Google-Smtp-Source: AGHT+IHGMFlv3CJq5ON2P1CXU3chlCJ1AW1l2o/aOyQMNL+CP1Cr91m5WBG1quOwlUWzE5FZule1TA==
X-Received: by 2002:a17:907:d9e:b0:aa6:7c36:3428 with SMTP id
 a640c23a62f3a-aac26bd5317mr4812971666b.0.1735894080258; 
 Fri, 03 Jan 2025 00:48:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef?
 ([2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aaede7ef3cfsm1424385866b.77.2025.01.03.00.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 00:47:59 -0800 (PST)
Message-ID: <74d395a6-92d4-490e-b25c-a41e9a9d3e11@linaro.org>
Date: Fri, 3 Jan 2025 09:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Static initcalls
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <20250101175518.GA1682161@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250101175518.GA1682161@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 1/1/25 18:55, Tom Rini wrote:
> On Wed, Dec 18, 2024 at 04:53:53PM +0100, Jerome Forissier wrote:
> 
>> This series replaces the dynamic initcalls (with function pointers) with
>> static calls, and gets rid of initcall_run_list(), init_sequence_f,
>> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
>> binary slighlty smaller: -2507 bytes/-0.23 % with LTO enabled and -1232
>> bytes/-0.11 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>>
>> Execution time doesn't seem to change noticeably. There is no impact on
>> the SPL.
> 
> This leads to run-time failures on SH:
> https://source.denx.de/u-boot/u-boot/-/jobs/986701
> 

Fixed as follows:

diff --git a/arch/sh/lib/board.c b/arch/sh/lib/board.c
index 53b1c147c2e..2daf54e7c33 100644
--- a/arch/sh/lib/board.c
+++ b/arch/sh/lib/board.c
@@ -19,18 +19,13 @@ int dram_init(void)
 
 void relocate_code(ulong start_addr_sp, gd_t *new_gd, ulong relocaddr)
 {
-	void (*reloc_board_init_r)(gd_t *gd, ulong dest) = board_init_r;
-
-	if (new_gd->reloc_off) {
+	if (new_gd->reloc_off)
 		memcpy((void *)new_gd->relocaddr,
 		       (void *)(new_gd->relocaddr - new_gd->reloc_off),
 		       new_gd->mon_len);
 
-		reloc_board_init_r += new_gd->reloc_off;
-	}
-
 	__asm__ __volatile__("mov.l %0, r15\n" : : "m" (new_gd->start_addr_sp));
 
 	while (1)
-		reloc_board_init_r(new_gd, 0x0);
+		board_init_r(new_gd, 0x0);
 }

...which kind of makes sense to me but I must say I don't fully grasp what
is happening with this relocation step.

If this is indeed the right fix I will fold it into "board_init_r(): use
static calls" which is the commit that breaks the test.

Thanks,
-- 
Jerome
