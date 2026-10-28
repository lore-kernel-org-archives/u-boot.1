Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0F606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qMF/ngDi;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xw3nVIF8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 060A081226;
	Wed, 28 Oct 2026 16:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sC-h-qK-4FO4; Wed, 28 Oct 2026 16:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6100808C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203329;
	b=OOr+uwh/vLv2/9P+//3xlXgNek9hyDLzuEFlK3GvN/IQyBAevi3SKFGiXp7VGCiCntZp
	 7VmCgDzR0DfxTiV8JJikt0bNLTryYSorU0D2NQFQ1xOQPBDY8lTym7gUZ4k8VW2txMVpw
	 y8L4+gSoxMu/mBTdBB3S1Kz9FU1SHEW4Sxdvt/Um4e+fwJjN0glAR1YV/30chMmL83Uk9
	 tN2hqoBcr8CrR12L4fHsJdkUis6lvhWt67E/8Xjt73E+WxOfs0xpIHpZot4Z+OSNAHoMW
	 KvNyGGBb/4iHn9IabKRt9f3c3B9O3TJNnXE0fmlwYGCAGMrxgLYhLr8PLoM4m+AS3/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ta05giyHHJklXkvilCdRxqJju2ZmMRVHRueC/vPGrWY=;
	b=d55+TQTzyiHPHl5jmPbfL3DaCMS/8Gvq+pqLU/atQAbKyHbS1Vdqffje3CrDRWuZesvA
	 vXUKISaLGv6Y6MI4ES2M+HY72Fet9fVB8Jade4qWd09ICz4VS6q259b6LQMQo+9L5hIbZ
	 2iyZFhdk0Sbhc/x1MBmXR0Tda/XVDSEQ3azJU/jmyOwvSHmeFljebBaybGdUMVLErfznr
	 iXbBhtWWBAltXRbLwBKtGlvVAbzeEw05izzPkd2Wyocnz1xzjfje8uE2SntR2+bGJLDOT
	 lZx1T2EJt9GLk6m/j62/Efn/heN1Vc5j78UJbT5EZiWDRdp9R57vYam1Wc4UPykdeqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203329;
	bh=Ta05giyHHJklXkvilCdRxqJju2ZmMRVHRueC/vPGrWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qMF/ngDiMl1ZYRKL3RC2Uqypq6F1coDOD/BVQa4Lg4xYjCK40nwyZkg4uWav/3yxM
	 z5LNbX9T41/wFiolX3qUCBgGNDGMPKgdPnoRGBVVjwV1SUdXZUItplWOGrixn1kZPo
	 GxT0l9SGrhyLI1arEfxL9bgmyfi+J7PmrUpWTt/R/PNxpL7BIWmt2NYdiT/Gf1v/xs
	 +M1Td89q/rGdigu1wWFYFczAYs9Elm+sxHZROBrhuw2w4vdMLgnmf3qayYylFRCNPg
	 IjzjpsSXDyHGxcEGR70Njn50/jXraz7PYELno235zW7KMZabnVNq525+Wl9ZfHPGbe
	 Fb++GtmAH5pCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6100808C1;
	Wed, 28 Oct 2026 16:02:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8010380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A984940536
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGalWcGWVorB for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9551040533
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203314;
 b=nRyY6ROEPUVZwlFqycN5CHFq7QMALKe4Mqm19VkrpxW6T7LyPGo6JFr9PBBWQMWobFHU
 UH7vDFegqU1fIY41W4CxwjUDDrfXtVYmMSeAcUMxCQ+XiQKzNufxtoHbwMIJpnUXVtQ+Z
 MJL5X5gxTv/qHO2uG0deE3uBaQFSDxaMICxpNEgDeXjL5ODhRIv5eunbtpDk0nvpQIFy0
 ShJWyVIW5XliExF4zXFKjjzpdDHD+S/TOfmX2ulvbpmKFj5wSGKPLQSs3cwJb3sLnytSm
 /srO74jp778ULFSJM9yufCttQywv7yLZO1Mwrd7pupPZQZbW2Iv+UimukS7JN94qvQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Ta05giyHHJklXkvilCdRxqJju2ZmMRVHRueC/vPGrWY=;
 b=R8kj3HEcUDA/+Oa4uy4wewa7RSwYAqIPxST9UuuMRngCphkP4yUMTv/bUnAJnLpNQbTf
 4UiLTKWtJlGpTPmYArBzbd6WH3uT5HPwxPt698hB9BvnTMiQw7wH1qveKh7HDDlGXSXry
 usm9vLnFyZSN+mQNvLmJLR21w4fUONEJdi0WWy+htYR4kb4SfzUzj3ZMpb+pLf9AkBeRP
 5HpmlVzZ3Ye2/G5KxOK2fLMzjJvdYkvyAManlqYusXodAzCRRLAMmWSqH/jeAfyrJO/Oy
 lN4C886cDsqPbMMWr/KUQYCrizi5VweYewTgT/+YSzWrokXIXBH+7Ov7VbD1mo6+BSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xw3nVIF8; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xw3nVIF8
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9551040533
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so11247725e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203311; x=1793808111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ta05giyHHJklXkvilCdRxqJju2ZmMRVHRueC/vPGrWY=;
 b=xw3nVIF8R9NDbbEqtXqKAbo8IydMVDpnF/BEt6UR81TkBLVMp/nLFTkO1H7wUodUIB
 EpfWPA7iUcD1OYPRUx2y8VjWDeAmOv0pxullVadcnPpOS9dJtV9dY/EteSspCNFlJwWB
 l0pAWlBITVRs5HP26kdt5hp4ESlyjkdsdn9MevV0ZZetqH1s+zEparJmaZbSF0FQnQtI
 p/UBzoK4XF/fpvMH7STb1FETA8l9UNPDabDQtdmnpHil+RKghj/C/dQJsEEZaaFL9HO4
 xEPSOkgmZive3IlW+1F8VO+W9DmI+KpNdiuDbIcc0pvpVgJjCSLWkdVZ9bhjk8Ka6h4R
 aeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203311; x=1793808111;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ta05giyHHJklXkvilCdRxqJju2ZmMRVHRueC/vPGrWY=;
 b=DtRtFYKC5ITqSeB2D28gSUH8xi64WDRudMK6O843ytwg1DfAALRCeVdeNmxXLgVgs9
 VglxybEGBKMGqmmwz6greyohDKuWs4docHSUALSNdmgKuhffPhqWYS0wFWYRhA5DbD8X
 cLwCPj2UbRRC3AhH0SdLMJsYtfDpLfvMaCKktWRaapHh/R/dFG/RSQDgTLcUgM8ltwr6
 h+GO960Joj49pG7DWYvBccVVF6R9lLsfm9/gX+WY/hXKGCtmZ7BnCdbzRsLcxcvfiLZk
 xhKqJiz1SSBRgeCNexZYg5JXvnGgwkBj5gmEhEz7WHnuM6ZhGFPrHoqYCuO+5KFuxN3M
 j+Pw==
X-Forwarded-Encrypted: i=1;
 AKwUvByrQ5otxR2CM2qv5nZJ5xOoCOu3GcbUSjACqGAzLWHrHNwurFKNRU1EKivl9oWlXMjUQp7Ob2U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJOa0BA8abJBfLgVjPN7Es++Pf7ge3ggW999hg6Bhldse7ekaVR
 +Wxv4OHz/d6+Q5uWm+RjNYry/CzyWEvQQaKrNN/TBYeQmCg/Dweeis2JV9KNpaVfCr4=
X-Gm-Gg: AYBFou1UpeLVh927+QtBq5GhXnHkxxk6VYSoQoazop5peQ2iz5KTE1ZVEw9WcAWtswA
 qw7jCyMsOg+zxhW/kNP/BHzcJfeYHj40sd4XZQbGilIIUwUXxqeQoPT1sCBiptbNzJdeBwqovZm
 oCAqWCbYMnVPEd4Wk9t1ZjXwwjuAvNoOlm1NpMGqNrQOczV9eTgQmWVoK7HViFPYe0dm5u79zxa
 rj6YAEMx/WQvwCYI6whqESNVaD1SOOA6yqia4eXwmZIGc0pN4HFO7tmJENtqLKI5avBFv8Cxke4
 0TY0gblIpeIUt19QOloOed/eBPf/vPyLO82vgkquPfoPf4fIEytXlDB9xK0+ZLF87994/oS5cQk
 4Oz8DYnHWvGwZuD/JfK26hzXkY7iXXd3oGK7iNzVVUvCThJ19tgteOQQAd2GBqB6q2WN6uO5aqW
 G0YpEaqZxsR6lATAhOgOgA0bnOE4FFVVMHJ4k4dfzD7upMQ5YlzLU3vjl34yUrysLge89YqE6TA
 FBTUAcd5JzM6m4lCjuTAphT/iF6N7/+rllmuQ4ORCntfCNWyjf3r1cubQm6TokwXZpe1bTcoeLo
 Q9S5JSqSkkYFnQt7CMbxAalpMrRZ6Dn36HpURyAabys8gpKdFcKBTJNp0PHQwSG9Gn1eRoU=
X-Received: by 2002:a05:600c:3541:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4a966f20483mr64080185e9.19.1793203311085; 
 Wed, 28 Oct 2026 09:01:51 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>
In-Reply-To: <20261024174234.3530184-1-aswin.murugan@oss.qualcomm.com>
References: <20261024174234.3530184-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2] mach-snapdragon: smem: Use available_length for RAM
 partition v2+
Message-Id: <179320330948.1454330.12432062621782962801.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 24 Oct 2026 23:12:34 +0530, Aswin Murugan wrote:
> Using length field exposes dynamic carveout regions to kernel, causing
> crashes when accessing these reserved memory areas. Subsystems like
> hypervisor perform runtime carveouts & records it in SMEM.
> 
> RAM partition table v2+ includes available_length field which reflects
> memory available after these dynamic carveouts, while length field
> represents total partition size. Switch to available_length for v2+
> to exclude runtime carveout regions.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: smem: Use available_length for RAM partition v2+
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b08eac429b50

Best regards,
-- 
// Casey (she/they)


