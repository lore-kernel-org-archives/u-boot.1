Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605B606A33D
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LbNQ0gWU;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ou600QPL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F30E4057A;
	Tue, 17 Nov 2026 10:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnpQy-PnqEhl; Tue, 17 Nov 2026 10:36:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E98B240596
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794911800;
	b=Yc5v4YCFqNO4rApO9WWoeAQZLeH7eJxY8sTbGrIrIp9XOSyWJTcUGvhxVouCtfKPkfmL
	 MH3HdaxEsNjp2Oc+PpC/Yj2HWmoCUyjwsjMp2uBTyv9AO+1J8MIZ9iLY6KJFkjZH+s5Fz
	 WUJ3Q7Py7eoDa/+vGLkOLutEEmKhgTMenjW6AtX0POCuSpS3/7N9Wty51UrrbrRO/6yoZ
	 +8VZ1iEdGMRD2SIBchhTSUGrVIn7yQ5lqYVaMyw/BPp4xUuaqL58gJ7ISk+0CEWjN97VN
	 DZO7dlGS3kdCiShAaRLI9fmTpnL7ft1PzRuv1b1bvE6GQfiuw9LnkCen0gOXUGxPvzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794911800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tVpK5Pem+LvTkgfq99FouSSCWCtrM49/yYsnbov3HtI=;
	b=AIqUx1nouxpM1jtMgCTD/Rm3Yvywz/TcMcrHo374qefc89U7ruwa3WA5fPAS1PPoONj0
	 oGEMFqQ3dmeMdR8sBLsCZrjBdDY+G9uh7vVYvfGfYwfAehmyO5OVxNBb06RBHgWkHcJXe
	 5P/+5YOyYRLJN+JSDNUUVCQs9U8tLqL+QUSVkr9t9CUmaNh79Dq7Kq2+jANv5oI2OdQh6
	 wV+KgXlIVMEOEbZkSETNYRLjuq0yV/S1pnD02Q2mhxWp68BxRLZUm6jwm4MJBsJf6+G4o
	 ITJdv5LBxcmiXroTf23VVDtDG14y6jZrkeNssieNKhfpGAsDjx5ILisNIuesENHCS3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794911800;
	bh=tVpK5Pem+LvTkgfq99FouSSCWCtrM49/yYsnbov3HtI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LbNQ0gWUqdsuzYNb5qvFOY+vt/Felj3dphK17jSl9itW8LtSI3Gxhn4MCCQvREbHz
	 92IUQsgWyQ+hLaKptSqFbIB2lHJIhCWsQq0ZOGuO/QUm4BMSOyYTlCo8qTDr+sJatq
	 JeaFdtIJq2Clji5vaif9d2jAih290oSF8PBwEEA1Tt68eqzjzLRGpmNTUxZRp7jSbk
	 stlR2AO+QjqpShF2kx7m8ftdl8PB4RZYnLS3m7NxYFD5M1TAS83GZu1IdeZNeN29Z/
	 PCiIIdHL9bgVpeFH/XmJkWKIazPwm8/vl40UCOvLthbIva/mtPCTaoKWG5FhlehvuD
	 JuA1ie7INdyqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E98B240596;
	Tue, 17 Nov 2026 10:36:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B71E1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCC0580F70
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4PIX4Nnra_8L for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 10:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4FB480F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ou600QPL
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4FB480F5C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 10:36:36 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3ae25c846edso35917511fa.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794911794; x=1795516594;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tVpK5Pem+LvTkgfq99FouSSCWCtrM49/yYsnbov3HtI=;
 b=Ou600QPLHltonxLTIBL9dXJMEI8N147yPMe2bEZtuq7r38sVpgbNCpB/Nrd2b20lFY
 odAlJA/VVwKL6C1AmaPBWRvxRFCoCjjPwLnJbjOCW3Fp8OiNAzltiQTtxFCrJQjuIVlR
 1I6yLcE5MjLKsXwdk03tUmGmero2bJEl9QaJ4MNIQvOdBmCDQbidcjSF8pQsSKyGV43x
 M8VKezn3f+j3f5/EnlcyKFXkHdSkmHUpwhj6H1UClkueHHqWvnl48tjh1vSzE1zCX9vW
 hA42H3BIyLmYbz+xXSn4zirvE75/aDdy/ksneW30Ib5c1pmjU0UW/GblqXvT3WtrVjoE
 V8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794911794; x=1795516594;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tVpK5Pem+LvTkgfq99FouSSCWCtrM49/yYsnbov3HtI=;
 b=tAo4kSiBd7NFxHjwbQkwcb/DDosXBi+dgboEuww5nWHea8DM0BGNuDD8zUgzpKVGB8
 Vd1tavOzRC+QV1/t6rvosLIOUd2OfAf6qF7iyVfBeL+4Gkaf6LmfYxXjzQnFZZ/v5Crf
 GmDllUjl7Far3INjZcCdWfdkcSSEeZRrOZ55ZRHpkmNb5WzyWlVlskwsoquNF7fii/Pl
 F/V/Kk6TCGcAjnO4GGqSoACuVkt+gONoIT3LLc7Ma02cPfUustee/4D1MS0NpDsfj+a8
 sv6Erbge/G+lIr5b3qP9zSmPAuVBIeoUcIfTHUl0YLnfVSPEalkfd+ur7pPyN3iqNyWo
 vmWg==
X-Forwarded-Encrypted: i=1;
 AL+hErHn6TQ99k2ItzH4Gzob75//krt/OEQNEo7LQdqAjm7khdDBhCHr1P6Qts6bJ5oukyWjKZYSqbY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+D2jx/71ER+LMcSRSOrJWOoaechmrzXI+bvdQXarTT1AiGgLOF
 0yeqTgoR3yfSeSgtDwd4imthCNT4PeNRsyzVFdSZHncLMvdUcNw1Q23gM4hkc4BJZwJXZVuyytn
 AQ0wBNtfJeZmW2vj9GcUzyRx/3Ho+XsA=
X-Gm-Gg: AYBFou1b1OLCB92p234AQ4hahHetveIguqBDkM7QArCSZt9sfSnhrIXzAQmXb0fE/3B
 DuTtxQA0JCoRKMIaEMikyHfaudN7iy0tSsSCRFevE5NvZbMQz9jKSVA7KUJT2KzM2LapdkHij7I
 veGipqY8TGOX1y25g/aeHlgL/dSf9Qga9RtotfcZ2c+g0j/wz9m3YI/D4H7XqnQE8Oz9ZVMg8Jz
 a/up3dl9Yf8blRZaeOOniXlYn1roZk2ZLdnE+pupT/5n2hKvh6Q39OV/0P8YAWIaCWfMeDlzGXl
 DC3cXsD48KRAT5oVDx5quHdeYI67MI/gm1YZ38IY5YB9RTPlaF1za3lvlu3edAY7j2tq0owyaGS
 DPmHP9GqxU/7MZr5LAKB0j6yeDT7fG/mv/S5K6lhAecsRIInpdDJ8OC2ligYv1jV+pVpU11lPSl
 3F1vsp+s4mAxJDmfsUE5+ZQWW5uD4cDZovnoDS5I1QZh41lUg=
X-Received: by 2002:a2e:a9a4:0:b0:3ab:f43:a3ca with SMTP id
 38308e7fff4ca-3ae2b66d4a3mr40635591fa.16.1794911793970; Tue, 17 Nov 2026
 02:36:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116125622.174214-1-francesco@dolcini.it>
 <20261117090205.GA266497@francesco-nb>
In-Reply-To: <20261117090205.GA266497@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Nov 2026 07:36:22 -0300
X-Gm-Features: Aa3M54pqvKQ655k4hMEdTqi_1vlE_Ncfc5_N8YvsAcfC65jQRl1OPGPEtLjuxEE
Message-ID: <CAOMZO5CA0uoMibbgQ1DU+JahY9v-YUZACBrXy4jzCSLA8KVGLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] board: toradex: verdin-imx8mm: remove
 CFG_SYS_UBOOT_BASE
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

On Tue, Nov 17, 2026 at 6:02=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> I did a small mess sending this series (it's not threaded as it should),
> if this is confusing your tooling, or patchwork, just let me know so I
> can resend it.

I noticed the issue, but I still can retrieve the patches individually
from Patchwork.

There's no need to resend.
