Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE19C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE0A80A52;
	Fri, 24 Jan 2025 16:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DPrdBN6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68B680ADB; Fri, 24 Jan 2025 16:57:42 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B469880A45
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e06af753so1223283f8f.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737734260; x=1738339060; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yalYa68gaVeBcNrUGzUTMU3bOixjZpkOgwmGdC4ZDsw=;
 b=DPrdBN6DgTA8QE9nko7rKPnmBU0xebWedICJkMB+82bXrk4WaaS/tCohCNlO7RXLSS
 O33eXcdmGa8dEY1GCGjjuJ3u0p4TTEVzH7NUEV6YHp8lQiUax4AtJJA+i+FPWADrD5lB
 H+UtLsVPfaRnj6zqcE8gg0R9ccGJUVdajEMRUmhyDjwqjLO2MOFXLvqhRkjLi6L4LTE+
 /4AyBj7ctQI3Ps7qomZVM0Tu3PE+cv06VEyLddtJStoAntFWATiNR3XRShy2KAkqrUin
 RnI/C4CR9DFAWUU16iIDjMA4PXX631+09FW9pFcAlKT+9VeuRLf/x85Vw2RYNBtGvytp
 PH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737734260; x=1738339060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yalYa68gaVeBcNrUGzUTMU3bOixjZpkOgwmGdC4ZDsw=;
 b=IScOjvQaBwxiYD5ps2xk2PXxC250J70OOQHku9TVU9PDcisrU7xVmac4e4BNOV7k4w
 GGbQF6HMhIhK73SCCVd/Isf+WLigajxW/1D4ECMw7cUsr2OPqXfndVWdNmK0YipCh8ZT
 D5WUbipUaQR+wLzGhl+6RaWsqyAbAmTa7xUtMEYb7A6pGJoHVOW/xZKWVbYMqQfkp6S6
 HvYQBcqgODw78GTD0x7lOEq9kHxo6pkXKCkJh5EpnyGo4LYwUeerUrmG4HaZHmr4wttR
 AW7L3vjvHvDj7OSUiuQykwo4AeaQM79lwVX18Zhn0JHpHhMK3W2XHIHPmOd6XIj12CE3
 jp+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSqPM3os0A3moYIwn4HKyuE7qNt0Mm/OLPnbvrrpZGpF0KtU/vbgtaRexC9LwfNPz//fzekm0=@lists.denx.de
X-Gm-Message-State: AOJu0YxqjDtTIPuAFp4blXFR+TpSmCn+ezYMWk18cJmBqD+sXgV/0C9g
 7FLofqn2R2YBeGpU/yC9tNdolPfYBLe0kv5jp+w2JjTjp4MACVXOA6iZfd9lD14=
X-Gm-Gg: ASbGncuvGigeUgL89y/3cKUTSfxoGdmHtGXfdKaHetqlBUMfTsnck40Iel9xzC8x8qv
 H2l1GP5htyFUnAewCoUiY/icHal9cR48vqByuObcCUPzCmVB7WrogEttEfdAIRiCVszSoQDqeY0
 8Nssaywr36ISwWvZnUWUuv93SRL+sarXwFMFdww4sEMA3uzwzMbANBGkgPetPvhyPQC6GhbF2NR
 3q+jFsA0es8v//yw5y/nm04AoFeeB57aMDH0hUbzaL3plT6IMD+22VEJDZUFi6vnHrvORCuOqq/
 pnQFrly3+xhfl6ohEp4Tpd0hwqSjS/cakmNGkeomrQ7WIUL+Xg5ViFDwRqzd
X-Google-Smtp-Source: AGHT+IFVCP07A52CISeCYY3dxaBR87aOA/AXFF2JUrZ4w0qa/h1/ar0MkmkPUk7R3qjWjoyJdrLibQ==
X-Received: by 2002:a5d:620f:0:b0:38b:d765:7027 with SMTP id
 ffacd0b85a97d-38bf57a2675mr21883174f8f.41.1737734260130; 
 Fri, 24 Jan 2025 07:57:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7?
 ([2a01:e0a:3cb:7bb0:3f81:732e:4183:39c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb234sm3045778f8f.80.2025.01.24.07.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:57:39 -0800 (PST)
Message-ID: <38bb1c47-8001-4415-a421-ff1b501f0105@linaro.org>
Date: Fri, 24 Jan 2025 16:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common: board: make initcalls static
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
References: <cover.1737709089.git.jerome.forissier@linaro.org>
 <564c3f3b7f70c893b2c6b6dfc89a226b90d411de.1737709089.git.jerome.forissier@linaro.org>
 <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <f9bfd3d8-dd30-4f4e-a73d-ab9082f832a8@denx.de>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 1/24/25 11:35, Marek Vasut wrote:
> On 1/24/25 10:10 AM, Jerome Forissier wrote:
>> +#define INITCALL(_call) \
>> +    do { \
>> +        if (_call()) { \
>> +            printf("%s(): initcall %s() failed\n", __func__, \
>> +                   #_call); \
>> +            hang(); \
>> +        } \
>> +    } while (0)
> 
> Can this be turned into some static inline function too , so typechecking would be retained ? Maybe the function can be passed in a function pointer to call ?


Doing the below totally kills the space gain (-160 bytes instead of -2281
on zynqmp_kria_defconfig, with LTO). And it prevents from printing the
function name in case of error, which is nicer than an address
(especially with relocation at play).

============
diff --git a/include/initcall.h b/include/initcall.h
index 220a55ad84d..097c32e141c 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -12,6 +12,14 @@
 
 _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 
+static inline void INITCALL(int (*_call)(void))
+{
+	if (_call()) {
+		printf("initcall %p failed\n", _call);
+		hang();
+	}
+}
+#if 0
 #define INITCALL(_call) \
 	do { \
 		if (_call()) { \
@@ -20,6 +28,7 @@ _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 			hang(); \
 		} \
 	} while (0)
+#endif
 
 #define INITCALL_EVT(_evt) \
 	do { \
============

Regards,
-- 
Jerome
