Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qFrfAqi4;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AZ9t4bTy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 785AF81985;
	Wed, 28 Oct 2026 14:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0XFRGsHMmihp; Wed, 28 Oct 2026 14:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 596E981449
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198937;
	b=knA90BqRbho0iGRiv4lkoEHLDY1XEI7vn415rdc6fOj3AcayMYYQcYxy7JoL2jQFy1W0
	 RaMc6qoEuycXfVHVWSvCr9SAX/4mxjC9AtKBh899L9p8p462D4aO7iFIyB9Sqw2Rmhn57
	 6EPa2ZwR2ap7TglTOKlfmgHYPLbVWeRXyfKCEKy2GJ8jUmFabx7LAYKIRZU5VS4tOWPsF
	 9t6Z8fvC5wFy18VW6rA2jd187lNnGXlpx4AN+fIMYj63gw+6aZITr5YDOd9oolJs4ZgRr
	 sscJH2i3++lmapYqVHaBPvCnrjzTas/1Fov+rTCoYrm+SVfa+BcuC5MM263JLcPkP6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9/gZ7VbyPMtC+CwO7+KWxGrMFlmMZYhe3lF0g0b02Bc=;
	b=ZRgT9m3otFX+/upZFrbWPBXA6NxXuHtbE4byByI4RXfCWXuzLfH1HvzF26R2EOUp1cfL
	 TI4/7nmAg/kM7J+BcPvmZLhQeHVCegC5QQ8fSjRi5DWmceHRNwfwkpjpeCrlbFAZWrQR4
	 9qLG9AgK09lY21hxasKLDMaOVCsUV9xlYHKUtrwVlxSER9JrOhWYXjom2NntC9ApP0McU
	 dpm6xj4LR7WcoY2QmUhFMrCVA+VbkzRAsnwRWqUP7y4gZHhsCOavnGlB0WsDmfjf2Ct0d
	 iAEptCUMStPiXDExavNH2huqTeHMj3KlWmyIM0kv+Kam4xFQcvcscUbNq3VSBAhN/0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AZ9t4bTy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198937;
	bh=9/gZ7VbyPMtC+CwO7+KWxGrMFlmMZYhe3lF0g0b02Bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFrfAqi448FXZkWE0L3n5HoTLdDHDpHh3LsgjzA50SZhp0QAMQc3r/wMmWZaFFumE
	 yU5HG9apys/BMoJ2XXv7Yki/h3Qusyaz2RfNDD64lnX7GU2q9AvS6felTF3T2VJjaF
	 w2YiVIzQeV/mIZSlvo7kNnczKEs9mPSDue2pMseRRQDE7h5suN8hhFWUL/hmiEIkm6
	 7m2umMh7toJbjltTvTqWAgF1f7qRE6pI8s9MxX1AtPHpyIZiVgaiTl4MbjFN3vhzhD
	 lqNbEVW0sYc8oaU1fGg8Ii3rdOnICEz0vRmoq9BmKNG6qcvQ43fcE0ktMqZLf/Q+xg
	 DOEuNwKJgTChQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 596E981449;
	Wed, 28 Oct 2026 14:48:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 810A4356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 728F880DB2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qx1DX-BWRTzM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4642780DAC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197636;
 b=cnqIGKTSdjjzycypxoew5o+/5qhZuavGEdmkrhINawMzflwHnLGA2Q6uzGi09l3jxb2h
 sofr06OiVfI9cOOwUGfcxFv9hDAgt2lvyJjGJRabLQrGlZT2CDgSu2qXn62YyvnYNPds9
 G7hBSo4m6J8+F+/86tAxSOr0Bz++CJXZyL/9yPWYkkcLwX1F1ER7dd9jpbmQb8nqhoeu2
 mEUB87Fsw3VlBW2Zhg+a13D2qI3wKEC4MQR1tbOhbN/ySJav/E8+6LVJwQkpuL4eF0PHG
 dpx0XERrLf5E4ANkgMdBZ8s88MKS4ctrN8KETF12baNxkJY5Czh0yMBwyaBohxflaSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197636;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=9/gZ7VbyPMtC+CwO7+KWxGrMFlmMZYhe3lF0g0b02Bc=;
 b=DJ1c1ITFer/n45xy6Y5YF5vBOXUBjbFlMbSXuVR2nTdwo1oWxdxQReiVCndLDMYHOnmD
 e3+Ogk/itgcA8u7NDiv6NZOBzmi78yR2rm1PIuAeY9o6YuUzqR5jhzYwCVw+s26xAcndD
 JIzAwL4IxQ5Ej2+pgzDu/sPNONBHz+98Xc8aLrzTJCqIaUMna7Bb2b3XRPjdYkddJhFGY
 jM3xLkPVQWEheQcq8EWQU1jw5rmj/QHwLT1wlc66ZXWVFYvc5pZMu317gkCcYVwFc2epJ
 CagfOH6ACgnECMLlxUlZHYVUVwZrCRvqCbbpsb/1hUW/HnpLKg6f297yLswJoZ8n4eA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AZ9t4bTy; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AZ9t4bTy
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4642780DAC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:27:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 734C81A137B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:27:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 41D9660769;
 Wed, 28 Oct 2026 14:27:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 98BF31032904F; Wed, 28 Oct 2026 15:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793197626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9/gZ7VbyPMtC+CwO7+KWxGrMFlmMZYhe3lF0g0b02Bc=;
 b=AZ9t4bTyBazYgC0HZH/PzaNZmSnQU2K4Cy5yWTSOxQ0y6WQmxwQAz+fvJURkQg+p+K0rMd
 9V9/4KQGqtki7ca/PN2OG5GC9IrpMlSsbwGO/NtBVrFu+V8T0zmEe+ot4ON49KkX76z9vP
 IghvU1PXvLAjHbYW+vhMDANnBUr2zzFSr7wLLYvA1sQXwyfnWF/VdmrIoAmJwwxjoPWknv
 pnIPLH2Afw4ugmU+QkG7mLhxSNCOfWv7Vm6X4cxbY0W1ietU9okWH3WinX3mNu8Pw5MPnJ
 aPc26hXhSovMmDkxHxy+kKlbzf7LQzAdFoUtpabsW1JRMpYBWSJ5MoZpQNmT2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,  Richard Genoud
 <richard.genoud@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Allan ELKAIM <allan.elkaim@gmail.com>,
 Tom Rini <trini@konsulko.com>,  u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] fs/squashfs: fix NULL dereference on failed symlink
 resolution
In-Reply-To: <20261028134427.405740-1-odeschamps.mail@gmail.com> (Oscar
 Deschamps's message of "Wed, 28 Oct 2026 14:44:27 +0100")
References: <20261028134427.405740-1-odeschamps.mail@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Oct 2026 15:27:05 +0100
Message-ID: <87ld7hgati.fsf@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Oscar,

On 28/10/2026 at 14:44:27 +01, Oscar Deschamps <odeschamps.mail@gmail.com> =
wrote:

> sqfs_resolve_symlink() can return NULL, on its symlink_size overflow
> guard or on an allocation failure. sqfs_read_nest() and sqfs_size_nest()
> use the result without checking it, unlike sqfs_search_dir(), and the
> NULL reaches sqfs_split_path() which dereferences path[0]. A crafted or
> corrupted image can thus crash U-Boot (a NULL read) while reading or
> sizing a file through a symlink.
>
> Check the result in both callers and guard sqfs_split_path() against a
> NULL path. Found by fuzzing the SquashFS parser.
>
> Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>

Thanks for the patch!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Miqu=C3=A8l
