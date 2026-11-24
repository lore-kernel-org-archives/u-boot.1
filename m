Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40545606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cXtCvn/K;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g+2O1jJb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CEDC8091C;
	Tue, 24 Nov 2026 07:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsgEpoBVGYqx; Tue, 24 Nov 2026 07:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5423880934
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795505633;
	b=Y2/K4aXciSM1dgM2a3CIKcqs+0gWUVOSUxU0xSmvBmaOdz+mbSllxqgcnxRKJvQxpo/U
	 nCNKIpk2ckecD8TZ0Y9PE2ECN6QRBagtfyekp5lVL9hkGsnRhHVdyNzRhtaX8NkcrdcDF
	 FqLA3fMRRohSrovVRCxzv2tMj/jiN4Q8IobQd+PDI46i6bMMTpsC/8SmB8fZ9mP5LxHY3
	 VhnlHdg+CR2knze6RqwzROChYpHwUpzzN0DCHoTSKPtS4Q1/g0pbTIMEhV3bMybvichcf
	 fJ/xNfwsnGZF9KYSt/PtbS2ORs41lCNmPs7hbilz9pjRmO6GRF4Aap5v6Aiue/6KQPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795505633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b0+eJ435luQ2C7jS6hc9UZjNd5i9CV+SgeR5CkaLNzM=;
	b=gpeYgKjR19kB5wT4DxtsgWfBPoabVXlK2IyQJA7+m/qtufNru6q/HK3Y+IbrQYXKrMWs
	 C7/UN7R9H3LGGPog4cl11Cvzr2EinVWJP3uLVigTP4Ao9jsd+/+R9JoNhLkascJjwzJRC
	 QUmcsnRPufc2/X9JZrno15loxcu1p2g/6qk78VlQ9FpByz+9MaB6qgOJrkqbzcS2Ehw3U
	 cU/fIyUWgcuL9qX8gED1vo+C7YdEpnmTsIS4GljHAC8qZBxNiCjD5uBTcB165c+93PdYB
	 ucF179bdlo1Hu0Bi3qhyhJ7TFW9GULUEIQdih+VfLC4QWR6kW0RqzhKJjnZejvEAZAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795505633;
	bh=b0+eJ435luQ2C7jS6hc9UZjNd5i9CV+SgeR5CkaLNzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXtCvn/KhB9vQ0w3kVmnAGzW8JPiN5jEO/yQb8f1yNuPwfXkqfTAWANFVUICXkzSm
	 WqyNDVD5rlk1G+zTeCERvE4VrL48YfgXHVP1/Zf1DhPPZU3K1sxODoiwgVi7VWcFP3
	 83f63JDfef3UfKvbBhaLV6a1xMx8Ox3vjQCQZEZkRO8U9wZ1jJIlN+ocUm+DY8eFG+
	 +7CLSIEuisFdyh3FmsYEu0OfyieBGMjM83tzYLLegV4B10eELHomcs85Ilnd/9v0Ff
	 aJP9ILxHNnLeulDaNjQC+nUKylnkp73zgCcsBiTUoPuMR5JeQbH/O1UpYc1O7yNXwU
	 mAvs3zYN4VPOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5423880934;
	Tue, 24 Nov 2026 07:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7398FFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FD0D40729
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GoSx0_2XZMap for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 630C340728
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=g+2O1jJb
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 630C340728
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:33:51 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso458917866b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795505629; x=1796110429;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b0+eJ435luQ2C7jS6hc9UZjNd5i9CV+SgeR5CkaLNzM=;
 b=g+2O1jJbkpeTqB0vaj9FSPGElbEiJi7qNR8OoatQ6p3QdXBdIU9yMqCoNPt+MQ9JYS
 DQ9ubMIU4hfSLliPKpoc4XXbBTeePUKkaULVXi38U3BATPJa0jxgFbK63uuLYtawUBOH
 fBrnRCo9S1TWVwkHYTw6+4cpXzvkZU35cCAlEpmc3C9LGY3hJESCdyQ7Ym/BLf9YFQgg
 4SYchrC7JHD+40S+9lCQ9nNrtnB+Nvz/AzGAIxHlo5eNsFWwtRDDVoZR1p1LCL4KDPfL
 WJMjR5/Vbjw3l+64zEJSbdAk7LVoxw9zAgrCLv4nPtmcSmsmzNm5/+XDlU1Ul3UqVhro
 OoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505629; x=1796110429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b0+eJ435luQ2C7jS6hc9UZjNd5i9CV+SgeR5CkaLNzM=;
 b=aFdRiAI8CxN/rlMcU5+5sXatOhcgsiS0ZSppCe1Zc6A4dEcp9CDFzIaik0e8f4Qyum
 SxjJJ2HCd1h22/8iHjlNUWCB3yANYpf3NPJxTfnYOV0nloqtgYpWhcDDZADt/+oMy7JU
 ZdVII1JlRY0Z4VKeyHW/gDPXKNtOFcu5hnsuVJo32js3Ddib+fIi4+oQxD2GChBHaz19
 7D/PxYMus/PX05LLaiuSRRtZWHh/nCfIior3JbOrZI7LmtGpAudDe5/agiHx9hFcl2SO
 ZkqeON/8n1zqjElb3gXwlydKUnqdFUQ13rpvqLPL0fOSgeH6w67QgWAmmrs5YubddhPh
 z2HQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgs7I8cziEfgAMVHw2IAQVd9StBbCSi95r2Zj/PA5OU+C/se/ScNfRpzhudJtZSoVj85lo0nc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+pndLj2lny82gmFX5cuX9Dr43+bcS3GNziwrA4n8e9yndB9awp
 Na7bXlRKrLiEBnrlihfzg/pMPaJL43ZtbkzLhe8tADEvW3CRMkhIxn54hlMY2ZGbzuyuZ7IfGFL
 3pbARFMMgG3g2bZYuux+XkJsOXD3dQ2A=
X-Gm-Gg: AZFdTZfB42wLXa2BWTZekUjBEtkmK/wBfVy88jl2HPsoW0kA6hdVic/B8l7+nKKVx40
 kWg5rX3MVU5dDzwHkEYsee5TX2MA2LoW3T0Amxpy+YKN6fUO9CLgE9+PbpScoc+s9Ym4hAf3GhM
 FmLaGDbciW3kPLl60m52cbIs6ZE1wNUqQFhKiiOhT5stZMqQaBaw9h9WBEKueGBJ+BKzxeR4B5x
 eKHfD+6efRxkWgZQf3CHbZbRkWK88kfCJh+1W/W1nCzXlV1B7VG9qKVAa3dFpZFajCIBWeiKSsH
 dUV3CMJzxLntMjJMIgg1gFw2xBgozG6pTXKS9EZAPNCMFw3nYlDV8LSlUZtFPkSTlWKv2mnxsKd
 5R9Ms+Wy1T1W2bCSzQ8Jy7LBmC9t58rfWcJIllq4=
X-Received: by 2002:a17:907:9306:b0:c42:fc8b:6c7a with SMTP id
 a640c23a62f3a-c513aab4a0amr1092222666b.41.1795505628834; Mon, 23 Nov 2026
 23:33:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
 <CABdDSeURr4FdkrYiHZFNyVAooA5qwOsTC=khseervB2gpkGtfg@mail.gmail.com>
In-Reply-To: <CABdDSeURr4FdkrYiHZFNyVAooA5qwOsTC=khseervB2gpkGtfg@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 24 Nov 2026 08:33:35 +0100
X-Gm-Features: Aa3M54qU0BTNn1wS7ugyGM9pIUxO7SL58dHhCgGwsdCg6OPKvGrYApiUMgKCbJM
Message-ID: <CAC928HZ8ipAeoJgYPtHySXGkiNVfmDdJFc3ApDKY-wx1TYZfyw@mail.gmail.com>
Subject: Re: [PATCH 0/3] LDR format: Kconfig: fix LDR_CPU and drop HAS_LDR
To: Greg Malysa <malysagreg@gmail.com>
Cc: Ian Roberts <ian.roberts@timesys.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Greg,

Il giorno lun 23 nov 2026 alle ore 19:44 Greg Malysa ha scritto:
> Hi Massimo,
>
> On Fri, Nov 13, 2026 at 12:31=E2=80=AFPM Massimo Pegorer
> <massimo.pegorer+oss@gmail.com> wrote:
> >
> > LDR_CPU has a prompt but depends on HAS_LDR which is prompt-less and
> > never set anywhere. Sounds weird. Instead, make LDR_CPU depend on
> > ARCH_SC5XX which is the only architecture using LDR format, and drop
> > HAS_LDR.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> > Massimo Pegorer (3):
> >       Kconfig: Make LDR_CPU config option depend on ARCH_SC5XX
> >       Kconfig: Improve LDR_CPU prompt and help text
> >       Kconfig: Drop HAS_LDR configuration option
> >
> >  Kconfig | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> > ---
> > base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
> > change-id: 20261113-ldr2-f0386fc693e1
> >
> > Best regards,
> > --
> > Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >
>
> Thanks for doing this. I saw Tom had HAS_LDR on the list of Kconfig
> options to clean up a little while back and meant to get around to it,
> but I've been a bit too busy lately. The regular build works fine, and
> I agree with the changes, but I don't have the resources to run CI
> locally to verify that part right now so we'll see if Tom sees any
> problems there.
>
> Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks for your review.

Regarding the testing of both the series, I've run the Dockerfile, and exec=
uted
the buildman tool on the two series for all ADI target configurations. As t=
he
series have no intended functional or binary changes, I've checked that the
output artifacts are the same (with reproducible flag).

Regards,
Massimo

>
> Thanks,
> Greg
