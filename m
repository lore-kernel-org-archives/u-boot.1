Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFA0C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1247D40CBC;
	Wed,  2 Sep 2026 17:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9fhIKJvyeZF; Wed,  2 Sep 2026 17:17:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788369429;
	bh=gOeWIg+H07W3Oksibo9Pf5X1ef3yyjcJTvCoVFQZUhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WrjQE/2Jx5jcd6XYexaFztjkAfZOKn7hjrLcO/0+Nr9mZ0O4PuCuHw3QgSvLM6IJ2
	 ikgKzZjIa5Qygden1CcutyFNGUjUa7onh7BbGQ4zhhRHZfNJ/odKt3bZ15eMbWjsiu
	 Vavb7TXwm5QdpVsFCKCFabnwu/JJmTshmK0CWgSnLpVIIl3Z3/pVbAEfHx397mB23y
	 dhIQy1CWp5ridfoZNXTN8C8lU4UVtux3dqsrWcBMNCBmvaHV0EoHWV6c5oAObRvEBD
	 FYPlWgHldpo0lzG+hzy5aQgUrmr3nocOaKMdAQjVs53bjPkhMF/KBZKRpL0D3jx7qS
	 ET/4JQK4jrKyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 809FA40A6A;
	Wed,  2 Sep 2026 17:17:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82C8C230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 805E040A6A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbNTJRcha-fI for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:17:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hPDiXMv8
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9289B40A3D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:17:03 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-9384cb251fbso86077585a.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788369423; x=1788974223;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOeWIg+H07W3Oksibo9Pf5X1ef3yyjcJTvCoVFQZUhc=;
 b=hPDiXMv835t6gjr5gwVGWLMZxkdoYLc1pIe4eJ1dVqfm8oW2+378Y3BV55l2SSRpCX
 enBMZfQqrRYF8eaQZWuYJ30wo8+Ea2ZBZ1vQZrsL8lpORp6HmP2Bv2eajiYK7BomEcsc
 XScOPCNrGzTnWf+4xOdFxVNotYciK6vufitNMmNOShN572kB/rRQygTePPYOgtjFf7Hl
 CnFUOOucLHzzVeXo9nO25sXt8xNtBtb0SvmLkioQKq5wwULY1BVyxwv668exbN4bKY01
 oMmpAYjvg5SiCqMuO3J2Hv1u/TZFn5ZQJKVkJIHnTftOx9QSZK0w3qlQk2CvdMWY9+8r
 YGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788369423; x=1788974223;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gOeWIg+H07W3Oksibo9Pf5X1ef3yyjcJTvCoVFQZUhc=;
 b=rAmTcGZLhnxT8uCx0HJItfJ2uGt9KQsiHBe62j4XgLihbD9QiYf6v1HjoTfjo/HwkS
 Q/TpLpAf/7eqjbU/r4avUa7i2JjXNTMYtSAtEg8140n/HZJBuJj8JC8ej8/bfqVtMj/8
 aooLXDLeyIpLRLJ7WYzTizFDWMt3yC4pNGltdpL1ukkZFoEqpIPZP90UQud7cUHZp6qY
 eI4XQVYr1pZSTf1RD1Z2QBBC5pV/H/yMJ5VSmlaagXG2j6Ejj//ovvxiXP1hdSBgyVzl
 YYLlLFyYRUbHH3z6MPFhkN1WnDryDHGNnVZmyoh6MFDbo+BW3f/FzjYB1bBj1Z8Vehrf
 L03A==
X-Gm-Message-State: AFuF++mg/CNxp8zyydZRGsK55q7NwmPvB/pCRHVmWsarjv1POJsVsJi8
 UHvvWfNxRgJeR9LOhCXIWvOzAMbXGU2KKp5Gx8LXMcQ/9KJW2wecypLNF/e1MQRC5eA=
X-Gm-Gg: AYBFou0rnzO720Yx+O0HGlu6GfJrFqPFkZT0zsQB2HzRFPot9/3aX4IypnoS8w2ZFJG
 Ntqa0i6eBycGsav5mbazv+bp3Dn3sNz/mOiRPdMvzUCQvgAzae30BWze2mbMtjhXIWBrjZF2O0Y
 5Acmpvi5rv+3VmC2+8H/pz9Q3qZlnRkYT5s9mCpSh07MbqqqZZQvGJlKDtb9diyHCrGjPfrpcAq
 NEY/qJxHZQxVgrSRvRGP/Ez0amU1VMiDLnAJSK0nV9DBQfTPsTxyOE8UP4qxbHY7avzghXAkZYs
 IOEvIlWrHo6iNBcKukv+WgmRYLZzNpWLuGrhAkmpS1SVBHjl15vr6GHnfhGBdX7vfylwX/xUmHa
 +izXt3ygXu527C1kyfrJESLG63WK/NyDkGXCzAQJbuv3r2wXNllKv7aOE10WZWvjuyY4LDmOpOf
 u2ZUNN+7uxeRo1H5ZsuL5M1AXtOtsq1rRXU441rX+JlNBL3xUl9laHmeXU30sohBSDuRmV1Lgxu
 f4jzWSocXRLBU4bIE8fUn8X823wfkN6J5QaAQ/N6Lk=
X-Received: by 2002:a05:620a:6302:20b0:939:d06:e746 with SMTP id
 af79cd13be357-93960f18eedmr668700385a.26.1788369422391; 
 Wed, 02 Sep 2026 10:17:02 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f35fb95sm252104385a.23.2026.09.02.10.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:17:01 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:17:01 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2 4/8] ARM: renesas: RZ/N1 QSPI controller features
Message-ID: <aphaDa3N37St_dr1@maple.netwinder.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-4-56b6acef0439@linaro.org>
 <7243d0c9-1466-4236-9d41-5d78fa1cae4f@mailbox.org>
 <apHK_Q-dogLc3Mkr@maple.netwinder.org>
 <89aa40df-e38d-45a0-a422-4ef045153771@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89aa40df-e38d-45a0-a422-4ef045153771@mailbox.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Aug 28, 2026 at 11:18:30PM +0200, Marek Vasut wrote:
>>>>+    select SPI_MEM
>>>>+    select SPI_DIRMAP
>>>Shouldn't this be selected by the SPI NOR driver instead ?
>>
>>The same driver has other users, but they may not all want DIRMAP.
>
>Why would they not want dirmap ?

There are currently 4 defconfigs which enable SPI_DIRMAP, three of them 
are AST2x00 and one is imxrt1170-evk. I would be adding a 5th one.

However the same Cadence IP is used in many boards, including TI K3 
am62a and am65, k3-j72xx, and also on Xilinx versal (based on looking at 
compatible strings in devicetrees). None of these enable SPI_DIRMAP.

Lacking the hardware to test, I cannot say if enabling SPI_DIRMAP for 
all users would cause problems. I would prefer not to take the risk.

Ralph
