Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A0FFA3729
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2B783A83;
	Fri,  2 Jan 2026 16:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=forissier.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.b="UXwq4Fr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E3B8426C; Fri,  2 Jan 2026 16:22:26 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F3B83A3D
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=forissier.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome@forissier.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so9837082f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=forissier.org; s=google; t=1767367344; x=1767972144; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ELBLV9gY+pcOkdtIh7FaI3Ht9iHVXUkcwQNxCknxVw=;
 b=UXwq4Fr/95So3zG38SkOZiVRRxPaM5l4xVs8DgNW4B2zAllSevh0v+H6528Z6mMZmR
 woQCy6jPWqkRA+LhzHseP0hpNgvZ6A+DcX/KDMYFJ9FQMF+JXsfNpT6ZcVpqMeG/S43+
 83HjL9CRxE7LMjQD5POWgRWExb9s5ea/l60dfXluG5bcOd359oSJP2J+kuFZS4vLBDqu
 aaypZnmPTpZBM4S4Dpq+sFEMOls7G95Mry3VLoCjvkHdXDGxElDCqkJvpj2ymf1OEsoZ
 uIZ9qWOB3m8SjmmYJnslqpvb0ZHBWYLzYWOV5vsb4iLy2tMoEzRU+8hrGMrzfVa5ov+l
 1s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767367344; x=1767972144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ELBLV9gY+pcOkdtIh7FaI3Ht9iHVXUkcwQNxCknxVw=;
 b=ffH6L8+0uXO17wHa6YIBTMQ4fA7wq2dYL1JPXaT8gac7VuQMAfnme6/gveg9sDosM1
 ElyhvPGESElEac875JZnV2C6gGfBRXi+bsfinj4ZyxLUjnqafBa3H9nArxxiZCyJdt7K
 BVuQUKH3kUftZV9qv/UPnNKZNbk7aXpLqJV46wjQ0lGr80bih72ydEy0V2H28QfUZ8yN
 1+0W3148XSXGz+WieJi67uOnCMeJmUDXQf5FY/FCtv1BIn+Eyb4DJtcnftXVST0yvhoB
 nDLQnP5pXi4WzZ/8ufG7cG64rt8BK4R8gdGOWFnozVVzeyl+DUyUvbBr/+xcjQx7EQyX
 mwPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIaiCnzn2Eq6sEeVcdnPTbrCDSlklTlui7XhmlGZJFDCAdGToViRqH83xhbG8hHry6hhkylNc=@lists.denx.de
X-Gm-Message-State: AOJu0Yww2rtLvaz5eT+GbZXkmNzYn3JOBnlbycQjHrpwjHMVcXDgKNDc
 bcwhLM+WjQWCU50VX82vu8ePte/qmvxm+m/iwOSjFT3zeDWRW+OAkYqqETT2vMMNDgU=
X-Gm-Gg: AY/fxX6L9EtkYzjbGtrCAsGDjzzTlqdjRZaYsGresmrmreqpgkFCzSVioWye/qHoI6y
 kf1p/H2VA3hCdYQdMUYtQJw9C07LI6V4qxuqgrMic0JHdBOuu0YLykjPY9B6sO8Y7Q2xduA02iv
 FvFZzqduCwEYNCipivKJvrcZ+f4xbUy+HZ0Ul6E4Jef0GCAIPB/uGxm9EZX+LTC3ao8wSNvdRoi
 0rfm1CWvZ4bolGPIB3cWN+JIuOuXgqsGwb5g9lj1BOXGL4XB0cCfZ8DUEcjSNFpP1qdXR8cTnvx
 LZVg/NqxrYRdQwv9A7a4lANEtsBIrDNU7v+Rp7ynuqGZJ5SHjo/eFOedwLtaS1ju/+/sLaZVfj6
 lABIjO8bKey+G9iFho1V1QvlHknYeEWNB9MKsXyHWMHSIK4CjqQA1wPzzotxTPQ4ugeAjFSSbDP
 4IuJinekuJl8zlwIhTn/ReQM91QrzjN73CPCpDvbfRKMz0+vk4Vqsxoo1e
X-Google-Smtp-Source: AGHT+IGjO+3JFdlWB51gx24g6LjqGVhms3QswZLA1VoDqUuiyY0pbCq8+uBttWrM03dgS/uDqGlWnA==
X-Received: by 2002:a5d:64e7:0:b0:432:5d73:79a1 with SMTP id
 ffacd0b85a97d-4325d737a32mr37547343f8f.55.1767367344403; 
 Fri, 02 Jan 2026 07:22:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093?
 ([2a01:e0a:98d:5340:ea5e:8e1b:d9b6:2093])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa477bsm85165254f8f.36.2026.01.02.07.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:22:23 -0800 (PST)
Message-ID: <fad49c74-fe99-457c-bc3d-58915faf34f9@forissier.org>
Date: Fri, 2 Jan 2026 16:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: add Microsemi/Microchip MDIO driver
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr
References: <20251230210633.501526-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20251230210633.501526-1-robert.marko@sartura.hr>
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

On 12/30/25 22:06, Robert Marko wrote:
> Add Microsemi/Microchip MDIO driver for interfaces found in their network
> switches.
> 
> Driver is based on the Linux version.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/Kconfig          |   8 +++
>  drivers/net/Makefile         |   1 +
>  drivers/net/mdio-mscc-miim.c | 136 +++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/net/mdio-mscc-miim.c
LGTM.

Acked-by: Jerome Forissier <jerome@forissier.org>

Thanks,
-- 
Jerome
