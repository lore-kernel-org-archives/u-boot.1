Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3506FC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 20:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 997FE60705;
	Fri, 28 Aug 2026 20:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdHkwEw0Gjc5; Fri, 28 Aug 2026 20:29:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787948959;
	bh=X1zrqpHtlo1/Tde2KnEqhg+GvK5LCyRAltO7ku2OBew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdZDwg/Elipb3JLSxP7ggX7z2bxaklvsBJD07vf1m4htfLFnHpzUij5vqXch84nPz
	 VCdbCLWZqP4UibbhQSjm+qiPEuYjGLfYpBsQX6/MJKTEO6L8BkZvBcmFL52vs1wlwd
	 vVAKR5ZwCE9eaKuSadokQaNGbC2MxA/BKz/Sbe6MZUiXpyxtvXHdawJVYXMwtlcgb5
	 iFgztJr8yQ97wGXsBF1BfNCFyPQpQCs8gWnZg58vtoSy90ClyCcd2YrAABlJJJdt+u
	 WtYzWa7QLE27Qiky5noEE8XEzRagBDgYn7/QU5VLIHsSNIL6NQm2aZ3wUSza0ppSvF
	 W//hbzZ8/T6Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 837ED606B6;
	Fri, 28 Aug 2026 20:29:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B39323E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 110D380F65
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3lO7C-veUHUQ for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 20:29:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::6;
 helo=mail-oi2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=j/em/kDY
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 566A980F6A
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:14 +0000 (UTC)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b379409c74so490776b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787948954; x=1788553754;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1zrqpHtlo1/Tde2KnEqhg+GvK5LCyRAltO7ku2OBew=;
 b=j/em/kDYzpFJzNAOi6mQr+qxx9zhOAz3Qlngcw5DpzYvJAk9W7C+gKdALKq2rUGveB
 eOZ8Dt+qIrqkzh/UW3dxYabZf/2SmPl1VVcG8nDQXigEr7ABozyUgsayy7zsmxHnnCWW
 BCp2OQ02L2JrLXYkdy69X1W5S69lS5i0AySPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787948954; x=1788553754;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1zrqpHtlo1/Tde2KnEqhg+GvK5LCyRAltO7ku2OBew=;
 b=dlU8hKDA7hecVWaPvmafHS+vg45/U4gKroGsLfcMZNC7uoyBqQnouWI5YfEK/cqr5+
 pGaXKLlHJLCa3q31/zVKOsw6g/bNUKYlulvLLTx9uMGAQkVkT+XdXmvYJmXg/FgkKiti
 yd/B+ZEQ6/OEn+CW1Yd5QSyDZhPPHG8Hdr2LmjSp2+7mE7JaqVfa/wlAyJtYP9SmsHxb
 0HLOTEylWNd48F1FcvSxU1pJzilNdL7bR3tGeC1K3/gTfnRKi11VBE0xqdDWhS6MOxyh
 uf+OwmZZqMGx46bZMbTNqKxulDI5+FBZk3zZqrvSuTUWdUVBbhoCo2H3+t5S1QAwgD65
 kYyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpE1bCiBLovC5/HVfYjQIxYSWTe+3F6k85vgDsq3rmBXkywPQCDtamMpr8RaKLz4rSe2vgKy84=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l05d+mwtJ23VY6C8izInbwA+txWKBr9IrJzukxualYtnakNaye
 eZoyWnA5lb8PFPqmi2zYl9lvV02V+KN2Qq1cqxHYsl2sVxno0ukmXoCh+QgCBtDijQo=
X-Gm-Gg: AR+sD11/BxFsDYvhCvY2OjRoUAgJ4CFzR4KRkbpJ4keP5zm0UxU5A5VAblMdog/59jr
 wyX7QsJ3hkzYRfSAXoW8bi+eWlfZZzh+4OpPg4XhKkQgM+YAxlFv4Ij7ANMbb1lr72Dhnhnxolp
 BT8qkZvDZGCnoOJDVuZzAm5yGurRdSqxTq9YKzsK5dgto2VJgLIrsn+fnQlIFRgBDsKWvV3c2nu
 yFMvB0r934xmCJ2TfBjymxzLvKHLA+9DZPIWZGI6Xp8mVBiPurZg/WWA+mFrrVV1sf8u3/M+EGL
 RTxcVj4NS5XWqZ6P3B3nupLZoap2odXL7r9QdVSU45vdExClVvwV2ovSAyR+oBLGdkXBSwxwjbf
 rx9qoWk+IhNEzE0+fQmz5/MEEXZRt25B4os6cZYSs10+73K5CnF6hVjkTj+U0JKksQESlNe9ZGy
 HgJZHNGqh/wtPv+hS88Wj7kpoQ/YQ0I9XSbHzArvml2/+kPjCiK8LUQeVZ+q7DYKP7DmF+zbI2+
 ExDhjudTShcTU4eQGeqFgyZO4kQOBD/5lxKuIlneuLzHWOqdbhJmzZybTqYkvbkNKaz32qcjWLz
 3/0yOzWs
X-Received: by 2002:a05:6808:6f98:b0:4a4:2424:eb1a with SMTP id
 5614622812f47-4b398195fdemr10578149b6e.9.1787948953966; 
 Fri, 28 Aug 2026 13:29:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995b83sm2100578b6e.12.2026.08.28.13.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:29:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: michal.simek@amd.com, u-boot@lists.u-boot-project.org
In-Reply-To: <20260824134248.25483-1-angelo@kernel-space.org>
References: <20260824134248.25483-1-angelo@kernel-space.org>
Subject: Re: [PATCH] fix non-existing sysam.it domain
Message-Id: <178794895262.264202.15825627233660812538.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 14:29:12 -0600
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

On Mon, 24 Aug 2026 15:42:48 +0200, Angelo Dureghello wrote:

> Change "Angelo Dureghello" emails replacing non-existing domain with the
> currently working one.
> 
> 

Applied to u-boot/main, thanks!

[1/1] fix non-existing sysam.it domain
      commit: 547b4d3bba7ecb4446fa55ed27f048fd27928f59
-- 
Tom


