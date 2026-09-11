Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB18C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 22:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A86F680F40;
	Fri, 11 Sep 2026 22:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0fMlNzbeLep; Fri, 11 Sep 2026 22:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A26A180ED4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789166986;
	b=Cy2MLWZcCcpR+jLTeLVK81TNd0xsGCY5jSqLVPef8E18brEa1vr8ln9anTBbBI8VJ0DB
	 WlyEf/CebF/u/4JFbQhovE4rsdjOqaoBSba+3bQ20j9iEOCQKPGj3RkY15JQaUpfFPrsy
	 MHZUAs+LWRCaGy1DqH8YX+XuCkdcz2QcdLrdwJWfcJe6x2lG3a4Op3Oaci2Z2F8CvT/56
	 eEz37HwYqjGuO/vznDEFig03u/t2YdeR4AKYX/oxWwG/Ub924VDagOZ1anc2VuqjNaV/p
	 dPbPg+9wGCe/hO7JG9dBJ4SNZLurczY6Ut+YxoRlA+PkVFQcuBGnybKUsxv6sLZiNJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789166986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vIlYmIGcq0K8499zDk4jym8aAoetBGAQ7p0qGVfbxDA=;
	b=YZBNkQ2VrlSijHfkw6ahgyQcLR4osW4qjEMHCZpV89IqipPt1gbFIGn4ga3vRd6e9F05
	 ixs1/wFxDSX4J6bzOxukV2nZKCVoZSg2NzC0T5gXR8ydfN/2Lyx9ocukMcTcPa2wsX8co
	 ODAJR/dLgKk8jK2QqUbbnXKaUOHxh9fMC7bF26PEgDLvLR3Q0W8Z0aBYon+CWfPriaTMY
	 jmOVzvr5ZGe326MTLhe0Ouzj03bKC2hFmhk1LraMyrb2Ao7VS/kS5hV3e4Wu82QqYeGRd
	 kOy3gt4YoHtMxKfMz9S8r72p77ADsaorll69/A0Dvf968Tgv15OBAA+UyY8vZAswVZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CCKlFpM1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789166986;
	bh=vIlYmIGcq0K8499zDk4jym8aAoetBGAQ7p0qGVfbxDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JncIkFNeSvAXGKYiKUyKTSMB9p/0cm73bhvFbz4Df7IJH/2gVk6lnFsScwa+i5xvh
	 EwXRc7nRDNLbvqxG4bDJn6u8374B0ht0zzL2iGkvYfpwrlcSuQTUR5rdGRGLSO57G4
	 ZmqU78X+sMA5sdjABOU+V1SjbC2EC2bvB0O/OJEQH6UXe/PyiBVqvFOEZV1JitIXYU
	 zFQ2eAD0A7rLiYmu+n43leGU0H/5WfXZGJexr1PP0ab1ClyyO7mbToYUjpbnLmiQqC
	 I3VwiV8jAdellUiL97pZrFzOVvFVdN7xpmmmcdWqkPL2qHtTRLwC5kJOgEUktoj2Y6
	 EP/0HyvIaYIzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A26A180ED4;
	Fri, 11 Sep 2026 22:49:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE10A2E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 22:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB1A980ED4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 22:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klOspEhZWS8L for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 22:49:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A704D80ED3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789166983;
 b=eSR5Gll3RPxdaJD5w842Kyy1s0uCPUzkde8LRvv5FiYEDTOB0STTwvaGNFor9CBOSDwk
 URHUaxoMIa9f1yEo9VLFw9Vbi5cMqdKG0oreaXHkt2nQIL4wYF5XqxVL43e1fyo5x2KSq
 Ps0YGlFyA906pYXT6GUlV2dljY7BgBtQ3aAjyQLkJpWfuTUWoc6RXYD+xhjDezq708XnS
 REY8A1qP3ZQZKOHESk07rgGuVU4MwqI0qbb2FeMPB+CBOBvOWOU4Wdsb5dn5LrI5ku63U
 n1spRJngGZjDaq266bvTffudz57CEwk2vjo4mjrqGO/c02Kwkwuku7jcXvLvzdQnLKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789166983;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=vIlYmIGcq0K8499zDk4jym8aAoetBGAQ7p0qGVfbxDA=;
 b=HdR82g05WBYv5/Mb6sjO64QxZnq0oQRPf13YjMZqE2k4y9Er5/eU01vK7ONDBqOFzE7X
 Dz7Uzc6+Bz4FxY4QZh8g/EEQkB9SauJAo9u+ZmQpMQOjLsA6qGVuCjUoC8TbHw43FQzdT
 EnpFHAZzYrQvKbHghHMvvGPZEeTdec932q8pEAA3dOW4z45pdZXXoScyW/a9TmoAVWUQx
 NbeczgIxYxFE/e8yzXArPkZKoqpkLUTKOvpDBKkqvYR3NojORg237Ilj8N05pfxYIUzEH
 jNiz1boHIYJKr9kMDVkHEnjWzczkpZDph22d8pTJDQ0THOSLspzW8xXP8Ew1g02BnbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CCKlFpM1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CCKlFpM1
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A704D80ED3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 22:49:43 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 5614622812f47-4b38bf64bfcso645884b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789166982; x=1789771782;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vIlYmIGcq0K8499zDk4jym8aAoetBGAQ7p0qGVfbxDA=;
 b=CCKlFpM1nvmyC+bCR2McMlcRXgX/aSlLTd/YkvKCnoy6QNeJ6ttuRmzRCs3D0oe3EM
 zSHCtBC2+cKMPp7aLqLRqZaQJ4zn7UI1vv5Q91gffBvr7HZthFPNadEZpwBHS2C1QHAt
 GGA0H9mybXII/lH6k3S3nyNkblkUP7ifJY0Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789166982; x=1789771782;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vIlYmIGcq0K8499zDk4jym8aAoetBGAQ7p0qGVfbxDA=;
 b=ss2Vxg6iscQgmLAzVNmpHU2FIG+MrZF+C4egXbfBjt+6/LRcsChiUpbjMRODiFquAQ
 zFsannLc1wUujnde7FC4DU3ZhQQRb+7GaLtd5Sap0TMfNFoBFoMKqCaG3iMVTq7VW91j
 kmHPBXeKvWywi0cK1twLzjsLLB8xIVDvfgTSOtQ6YeNx9lGkaiKLPf/nkMNZCj47cBN0
 rhREQNHjYRqyvNHAjj2jLPQcKuLjDko7Olif2SlgPFjrI6wyhJzWpMtReiM0DJuzG+nt
 oWe+bk3MskQjeLq2tq0KtW8nsKIPkVVW7H+WGZ27OAhepAJIm5VpR3kjG1r/FMOcAnTv
 i24g==
X-Gm-Message-State: AFuF++lzV6DkyDq9ZqHYDE1hb+2gF9DEnLjrU1EK/qIJDL6+QyT69Smy
 2epoNdgi2AGRjCzTEKt/YJTByffgFa/HX4nKKdR0+4AORS1eHZRjhb7pYp0po9VLCuAPGQnlWEL
 gZx8qtfQ6W33qhDI=
X-Gm-Gg: AYBFou24xiUa0C1jHnGLZl1PT9MAFTWWy71Ja+HRaXTYTNCRkV/S014D8WxKhpzWIEU
 bX1WdY5wIJ5xTjVoWHfRqYMGRQPbaxN7RIeNmLUiTKTYgykgSruuVrNgTXViFn9cv9s7FJkubyL
 3FhbySdoSP58a8dc8M3ZrTgngnmQCKJ+YaFYnofBGMTu6R4f0ThwuZLrT4pwA4YtZIizWP2xqbs
 EgBEq34Xv1Ff3dSoViL3jC/Ey2wtPjWlcXPuh7GC3MTTPDoPNvOYp3v8I+pScff9mbk66i978W5
 sDaTh1YxAOerCkBpCS9PewjghyiRIkmDATnN5sQ1W0lbaKNP2RJDyMmP/WFxbSqXWflG/rP2Dmw
 E+IJInUGJbzS4OZBI1AaWiAIUVYh96TfzmCU3HkXeqlkOdUcmZFkCkvB327jJXWA7yjeec6Ojde
 unmDgxtPwsEOvWflYQ6uJG57tTzyrQ4I0gIfqg4dnFBzS6eiWAdpFPYQDuCVkp3HW30LDwc5u4i
 OAq1PkwxXwivFp5fwMEYRzw1pmXqPqAUaVyeOGiRFuTepAXJ6rYbsiy9GMATXXy2aTm5fqd2GTc
 aZP1liKfIDa9UhM8S5Y=
X-Received: by 2002:a05:6820:2903:b0:6ba:3635:7ffd with SMTP id
 006d021491bc7-6c0bde5bcd5mr4659442eaf.64.1789166982036; 
 Fri, 11 Sep 2026 15:49:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09690af1dsm3853782eaf.1.2026.09.11.15.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 15:49:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, alexander.feilke@ew.tq-group.com, 
 nora.schiffer@ew.tq-group.com, hppiscas@163.com, rafael.beims@toradex.com
In-Reply-To: <20260911165733.1611766-1-festevam@gmail.com>
References: <20260911165733.1611766-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260911
Message-Id: <178916698065.3839633.5830137843665013774.b4-ty@konsulko.com>
Date: Fri, 11 Sep 2026 16:49:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 11 Sep 2026 13:57:33 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit d4152edb50356338af994d1c0483f65b717b4c15:
> 
>   Merge tag 'u-boot-imx-next-20260906' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx into next (2026-09-08 11:48:35 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


