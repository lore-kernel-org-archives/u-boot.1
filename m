Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79C606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wk3Usfss;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WFEcFP+O
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 730E881412;
	Thu, 22 Oct 2026 22:48:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y4GVwSDTfAy0; Thu, 22 Oct 2026 22:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE98E81429
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792709279;
	b=GxEz8Vi3fOldukpuz0VZHtJHs/uVYMGAaNw7d4iXyypMrgpwnxRjS7JkqxTXn+9va7Xe
	 U3HXZZIBhzBAYC5SsCCAjETWA8bU7yvs7fW48PrtBZpsScAT5UkJZxiifMKRkPaXLliZ8
	 xr/qGNyqxz6ZJxFJbSIOcxrwmBdJPfwdZn0UbVhPMfBngRAh160Vzt5Dxghcs6R0gWOvF
	 ipLbhlMU7WCC29SfjRtoKs9qc6QTMgjZH7MoXqD4ajcjUGCE+/r8txxz0+JqEXAC316/C
	 0TxwJOgjIIERS1KJmWxwAc1eEMyW1Xmq9J/TPrQ6kLD+DkgXagAk9F10+ee/RED/cxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792709279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iN8B3Iii4mZOtlhmo4MjbraiqETKyZAThqPAgiDnnhk=;
	b=Q5jE7u8YppqDOpRZKBDI+SxIhhCaqBz+Rm2gCixpXO98oSYPABgGyB4fcfoNmxlzyo3z
	 U2iAllVqWq8yN6d3fGe4fLSCRA9TpN3ZtmkneMKkCvgzlNKsl2ht3aJyS7vqjNmxlq1hN
	 mBl8YhMQZlKHyKK3eCyjzXjxPDobgoADAYi5UKf0WjsHU+cc/BN2v7tRk2htVFoVj292U
	 lmBJOMZZz8+AI3jCrkZSTe8DjJlF8n6mciThF8NLMzzEQx/hQmmnUA0stOUwgHAI0mAif
	 d0kuDXO0+EDqAK9v0PerztV/52eELFXrldL8np2IovnScpsnjCMMuYp/yROV/ePWoEA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792709279;
	bh=iN8B3Iii4mZOtlhmo4MjbraiqETKyZAThqPAgiDnnhk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wk3UsfsszRcUHYzjVEdoU1mmPROGtXl5EqChB3RRv9dQ1+7ZvOt57S77dWNmqnjKn
	 RIzsa5BETEmYCcWb4OLEP1mw3fRoOo9b0moeJUUfGNEH/u+T9ydfI1WufvD6FWnKL+
	 ckUkGa6UjZneY6q4mvEDTgL6nEJxcbZp+pASzedzfnHUAGLpn/+T3c5biUmrYXgUEZ
	 ABlvjlWhXbdRwCVFPxbw2VTm6zr0UybWZ95jztf0/ov7FZjEaU6WGQq2g//+JvZRaW
	 ZrahCar5oa5nrxmchKfzM+C5IZyTZMRvNdCOHQPelJhi+UCRB/MSiq1hNU98IN/GLp
	 Ebb7HrT8JYWNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE98E81429;
	Thu, 22 Oct 2026 22:47:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14D1B1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEDFC4040D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUrOSXEmhV36 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 05D0740111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792709277;
 b=cA3iUPgFlLIPqCOmuYab9loB/jfVaFviEXth046PRy7EI9jFri0iR26UfDu5X2pvjzks
 tRbiqXpC67fKAY4AzPL2MlT8A3uVw1/5ZMxsFcmHN0cEKldcgAxoIEfawvf74FFValFcS
 yGtgwRLZyMxmKg7RFR/7gDF1elcB/asfXHz93gzM8n9EVCdbhcUZO54foJFNYACDTDjo8
 xtJpqaO9xiBX+djum9ktnQZrudu85XnuHU6duZY0D4u13Dm/7j2oTZkq9anrcQSssaiQ6
 glulq6fR2MwD0enxRMcVqr+uiS3lwq3y1ZnAVsa96JMrE8ImWXeIRwGeUuKEgUbCWUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792709277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=iN8B3Iii4mZOtlhmo4MjbraiqETKyZAThqPAgiDnnhk=;
 b=dY7oO6pKbNuhUZcp6PrEgUZ1WQe9PpoKaRBKfWnlmSm1D2wZQ33y8iyDkdGWOfTFxwb6
 OXlf9dUPu+Vg75/3gDgo+bS28xme05qkU7dUiyjVSHyDbKSsM1oQqw0Z+qOLvaRDCsrI4
 2Y4r2E5yD3j8CKyfKNiBzmD26qs+7w+DrtHSDTT7ytsPhqrGU+q/znNvH1goju2Iz4gFb
 OC2HChwUP4tSF+ZeclPcCAK9N08/wOAtTxTV+10b1K5oFCrg4vCZnUYv2yz4p7FrNWcEM
 WAKp5Y9+9IaahG3Kk7dM1ZVPg4FOVQH6Ge69w91bYuw6dxFmqHFXfjmA/pdTOZXQXtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WFEcFP+O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WFEcFP+O
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05D0740111
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:47:56 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6f74f6b46abso161729eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792709275; x=1793314075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iN8B3Iii4mZOtlhmo4MjbraiqETKyZAThqPAgiDnnhk=;
 b=WFEcFP+OyJ4f1n9pSUok0ptwEzxPvI3Ft7+mXKBCko7KIehk1aGtEgWZWpGL7hxLe6
 aP4ONTInipFqifjHyo6gdZKwHCMmQKM9GCFZiPg0Jwn3G+yebpOAdm/Uz3EO7jlNfOm1
 DqxwMJEkeCQnnpvKcbGIFEpg2uarlE1aTkZiyk0SsKGRT259vZroOZYuL9XGuBF0aWpf
 dud/d9uYEkQNXQOrO9CrxGwmPlUHSRsmrxCXLFf4b00q8C8BGuYSCf4+yIAkb4qF4Kpm
 84t0jvoNJZhoY/iq6j5FbQmT6vrohUC3xlpbJaYI98K7ebMhXM7rICjbjkOy654453AB
 cMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792709275; x=1793314075;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iN8B3Iii4mZOtlhmo4MjbraiqETKyZAThqPAgiDnnhk=;
 b=BMM/uDm62/R/yL3+DeCEX9f3aOCrb6UcqelqtL3a8LvsWsZVT7WG2oqyE3KENLNJFN
 stni3jnxI5G7sosqz+nUvTqCYjDuUvKs+6UZvOkjHoFHkqHBOf9Fjs7ZfweAAk/nxx4H
 F7MgmKO28i8CIZUxOKxFwkLPZBChANMhRkxSkVwWHlpfyQlqXIY/5HH/ySe5j087LnXa
 EquVBK1De6zs1K+ZjRhL/RCWuA+hRxp42bZAv85p98rJXN5S3xwiim47AYOxecE1heUN
 5hkiw1kVfd4a5hzDfqtzxD+PHdrFeC5Xj0RzgYrYC4Xaunl1y9+ciEWInJ2CrNxDaRHF
 9IkQ==
X-Gm-Message-State: AFq9FYJlE3NCEcCdIARPRzRmG7lRK07b9Xsnxy90gpolJ6IjpxOUMpuY
 Cc2n4/PXoeb3xAniNPWbl290NBpuhoJcb7NqRQbDYhZ/vQKf5opH0YhYe4u9sg2w+/Y=
X-Gm-Gg: AYBFou1sC4/TaPC+2SP9ZjXc0XSAeKc67NKqVd6bABoOSMgtcJU4S8Vvt3bApRBhxT0
 QYhSdmlDEtodTa0+uJGGnQ3RdWtcJ9glQmgvSOccZRvz1Ggq8DWorOamcg00y1/fhwesMjZh2ew
 l8FmZOWxpTBcLly7PPXTlJAE5LyB6a8ISdMW1hi6n5yibRu/57qi+K52QykJ5malyHcsm2EjRgy
 69WeWRgfD2mCReuwKMTm8cnbgW6/NBiqeKuTVfTmBc1DGoCfaLkToX1DKeaLL9HV+d3/W+ouwky
 Z2omKmlq5Hu8T89S6adriCz5hixGaGLWlT0fGfRi79Fmwczb+z4DzglqXwhEK0QW620db715gHd
 oLGLNzS+9TjvNhaoB2O7rbepg8L8dTIbjkJ1jGwXEmIFM2KuGXofKPIN8hdVavJi909HezDYpik
 8p/+eZwu4BuW2uQxLizgDLx2EJYlWk4iC7Eet/8BsQJCkE3sTYhGG62V9puB1QrjMwtw2c7pg6c
 TBieRsiCHlqKpu8ykOIQYJn4aEY4Cl0s3tw9KZ+6p9cmaZ2mmyTfQQut9CV
X-Received: by 2002:a05:6820:f00a:b0:703:feba:69ef with SMTP id
 006d021491bc7-70b889a026dmr552245eaf.27.1792709275231; 
 Thu, 22 Oct 2026 15:47:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b33dcecsm423964eaf.12.2026.10.22.15.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 15:47:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
Subject: Re: [PATCH 0/5] splash: documentation and more storage support
Message-Id: <179270926355.3711947.4503997234172834726.b4-ty@b4>
Date: Thu, 22 Oct 2026 17:47:43 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=morNfCMlffAPKKSxeCoA7Zt9Cbt63JI/L8JtIm2WLS0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2pKRzKvK7luA2mQTeZHX2JwwA0GcPdVXiulx2
 VieA5t6fNqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatqSkRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AN34IAIiY/NuaTX9f5dj39TqSRYNFsVqSa3DjJzqg4IO
 l5FpDLFdAs7j+F59OW/OWHdtDihTACAGE8S72m9TRxaIe+rquy+205veOWVqlEDFuH1NexJ0QE8
 TvzWWJ13ysdNq6hKgTX91RDEmr5LTYvhVv+GhUQ9If7RMo/OTzy20HlWTJMalnIEqGZRjwqxUFo
 zJdtw25rD+t0MWGbN7bxsqdx5jhJvMy1/riizzygAao947+t37iGFMnhq24XV6lGafPeM/b5MXw
 r9QCQeMKxivTDmrI01eqxHx313sFDOnsb3UNAc80wpBtinijDPw+snm0Qr5qEEiN/tbI0ucQSCV
 eZ2E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 08 Sep 2026 19:02:29 -0500, David Lechner wrote:
> splash: documentation and more storage support
> 
> For the MediaTek Genio boards that we are working on, we want to be able
> to use a boot splash logo. There are two cases that were not covered by
> the existing splash source support. Loading the splash image from UFS
> and loading the splash image from an offset in a raw partition.
> 
> [...]

Applied to mediatek-for-main, thanks!

[1/5] doc: splash: convert README.splashprepare to reStructuredText
      commit: 5c5c06e1bb4d3405a05d43d94328531e1e53f436
[2/5] doc: splash: document the features added since 2013
      commit: 743308342d38f51276ecba571705a17f7e69a0a1
[3/5] splash: use u32 for the raw storage offset
      commit: 2de12f01388e651d0126e7cb3029ba7bea559b9c
[4/5] splash: add a splashoffset environment variable
      commit: 448ee63ecacfc7ec82443e7421737b624ae8e600
[5/5] splash: add SCSI storage support
      commit: 345c0cf837ca93a97dbdd4886f986975f462376b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

