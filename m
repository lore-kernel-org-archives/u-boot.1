Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99887C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC9140C3E;
	Fri, 14 Aug 2026 22:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZIlyQPXgq2I; Fri, 14 Aug 2026 22:10:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57C6640C35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786745421;
	bh=qpL4ousIco/+HgSA+zBlqFRfK0nskc0U7Id8/sp6sBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S/fVCJHJ8dgpAo52iFRlMoAl6bE1OxW+qiu4VQ9myzEBq0wOe1hZqdRiZzGZGhoVB
	 2u3Ec9zshxFtD78mHEeg86aoaYSUZraeXNUrJ1BBmNDhwXXdIWitSVEEVWlGQYNUlS
	 zPteRaq5SwvFsqG7wc4P7YbaNVVIyf2d6R3/6LM5cM5qELs1Tuy1CQMc0+Y5Wp0MdP
	 gWAfMmO9ZgprunvrenYxOZ4p1r070qTm9DOpkbFVvzDGLSi91t0Gxp028hjZjwXOUP
	 ouLSrPB7N5RBR1GlURd4UVa0cHJscAeZ6mKXhvs86T9B0vCoJRuHJlf6iYHirRY6yv
	 ARDjEdmQ984fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57C6640C35;
	Fri, 14 Aug 2026 22:10:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7904D3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6221F605F3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrzORdFjZCOY for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:10:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7CB72605DF
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CB72605DF
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nV7pOVJZ
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CB72605DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:10:19 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39f91ba1ef7so10565541fa.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786745417; cv=none;
 d=google.com; s=arc-20260327;
 b=FrrMYxDhoQcW0xThot3cKs6ulBjzw2rGEjnOsbsaM2+Bh2ATlyU6ZeAHVejxYf11WU
 S3cS/I+hAfntzssOG+ygSi0dw3DqiWoqy7/8zPa9g2308EdL2vbmqxEoQP3mVLtxUBcl
 3a+tyJt+u32fhjAOmbV7amJqRKlh1amkL82wI7OXS+ytYoqz3MAAIbbw2MWfP/bt40R2
 Yi9ugrinlNoGVEr+EDTmOa1XRuFtMi3Te96v0JFfSeaiKt2kPIxNoFH4jR0qqa70Qcsw
 syxr0yMIObUot3swjJZ4MaxaGX5WTozvfS0kEwxhgPQmCcLPGDiIpg5ANDXrKRIf5pL4
 Gstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qpL4ousIco/+HgSA+zBlqFRfK0nskc0U7Id8/sp6sBE=;
 fh=p6s+L9IMZwJsSaWTtXZq/fFXAvUq5dTA4hx2MI9Fiiw=;
 b=Fn+/YZzCTXsCd7nNviwGysiHAfOEMKz3r2dWUrOjSNsmjCkuwTxwLYABhbTEMHh/Bj
 pXAgfXlRwTw8938xAMr67nTP6/PMuCcwzbNyKow4EdXLzKXEK2mQm+oS1UpEuSO5yDdP
 Iwp3TEcCJ90fSWtNz+Bk1bK5IuqejR/T7RpeWCbwU7jbeJnEQHoFP3/GL+jpKuHNTBMk
 xQU+P2kl0sVIw/It9S/pJgDiF3q59sIitFwDdB8P1EKaSM3d8vCvWO6PN9q2LhjwM1Mj
 3vlB7bu+/KOvyJppm9ugm4nsEF98gx+Fw3dN1iXGw0Q9lFtFITp2fXqo6OJzpw9/rzyF
 BHpQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786745417; x=1787350217;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qpL4ousIco/+HgSA+zBlqFRfK0nskc0U7Id8/sp6sBE=;
 b=nV7pOVJZWPUXpgb/n+YhuUX/ELWwjhLVauYjq1my6sJ0iKY2OaOH5ELMHsHbaGzqzi
 ecX9alDQX8Yb5A6cZbrvDSUSbNo3OPJfjYaev6QdrUzunauDjuoGsJ04Li4hY6bJE6fS
 f/pyGgdEOHt51AoYkR9DpE0G/QurhNVqtAocESnZza7Q4cc1ro/SjgcXI3ElELPIgoxy
 TP/0tU6giCEaPZGr5O0kuVt5nULMUpNRMnqTsl5Cw5YXgT2rx3T8rVgkcHu2ObTS2ufc
 dsDYsEwtPwbXlkM0ceV8mJC/D/YziCvFp6M/iEtRIqMbR0NY+jdyE9z7yipz7Hr7pHss
 HJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786745417; x=1787350217;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpL4ousIco/+HgSA+zBlqFRfK0nskc0U7Id8/sp6sBE=;
 b=BrzxO2o1Iyl3FRN1eZ9hStoliFV02C3wyShGfsUgrSfK3EQDWOsACDFMID/7sASOYH
 bAh8yYa/z4SKGLBiKURUzWzo6ViT8+FyJ7UqADQE4LsUcg4feppDEgDAqjEFPUZnxYgR
 EknxNa1OW32rju6cYrwM17LzoSZBJwsVwp//5KE2hWzF/hgLejB2/Krtg8ufE8LONXJP
 XTzVwZnciLLdHhBBK2HGn8s0sekZmU+Fqwmdbat475oB5CRVPU+USJR2TW7+ucIIvxkZ
 IaLxOd4cHIn4wucaab+mWy5297zzTUrpkiLpt+kn+OO88yl6oCEjz3TrB3XIqfhEuw2z
 ZNYQ==
X-Gm-Message-State: AOJu0Yyiz+3YhV1h1MmFGZ+FF4xZ3wiqGbZApQuU4GE8OX9eNneA0FD6
 sXHi3TGh6x19WGeQUz1E6d4op86pWwCI8ZBSqUcW/d+z3yGNYPMOjKIBcfwVPgW9B2TxbVSeUPr
 RxqYmAIN1+vy8WU9ktygNdsKxg6F1NTmaVR1J
X-Gm-Gg: AR+sD10wkOpp7b+soVldkzHltCedywUIO1mA9l1Ka2UTPqLd6zCvtCmgF64t06SNn5K
 UDYiYS3VbY8f2NsuQZFA/GS5BOzLN7ZMvbw0xOVXAuKJ+l/Giu0emaU1kYj+XzNhcN0yH2QO9nh
 f2in6vFsu6o8Wa6kjVdN5AEy1Cm/iaCd1SBJW6brFffGo1lrJaGOmsylDdpQOhKlnC6kdjfg3dD
 2G0Uw7ELhQ3PBGkBKpHntNhvQJh1h7F+eRKCPUSnFWlFMtkzBPDK9ZvjmZv48arXd92I/C1wVAl
 YmoNURUtPpGeZQDGG9xU4nATWx/85J9BsiUB6PH0Cx6ja4g7w8IlomnOE/zwrynUCvrx655X1L8
 DpvNjZZ7qEBEGVxhPehrrmpxa2noOR34BRJhZFfxh5DyhOTrR
X-Received: by 2002:a2e:a99d:0:b0:39e:b3b2:e95f with SMTP id
 38308e7fff4ca-3a1324b41ccmr9109391fa.18.1786745416933; Fri, 14 Aug 2026
 15:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260814220723.1677460-1-festevam@gmail.com>
In-Reply-To: <20260814220723.1677460-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Aug 2026 19:10:05 -0300
X-Gm-Features: AUfX_myb0hnBbZ1DCRXP0ZTRdqrgs850S4fbAfZ8O5Zm5IO2BHrRKvA7WxP_MGs
Message-ID: <CAOMZO5DAajOJRhMyYXvezMXoUgTCymBd0LWuRoTFTRAFH3A8JQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260807
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, franz.schnyder@toradex.com, 
 frieder.schrempf@kontron.de, mehmet.fide@screeningeagle.com, 
 stefan.eichenberger@toradex.com, S4210155@student.rmit.edu.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Aug 14, 2026 at 7:07=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> u-boot-imx-next-20260814
> ------------------------
>
> CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelin=
es/906

Sorry, the correct CI URL is this one:

https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/990
