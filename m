Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E6BC982D8
	for <u-boot@archiver.kernel.org>; Sat, 19 Sep 2026 19:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5108840CDA;
	Sat, 19 Sep 2026 19:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvjwE8skWyC6; Sat, 19 Sep 2026 19:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E175F40AA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789846285;
	b=LFR6RfCz9z7c5jdlTzW9QMNw6E3ccq7tml7S+XeSEj1Or8MIxJtuXCkMpxmbTNJYvyMP
	 FaW4F1RO4x9nI0WFMhkz0A8k5uOIKc5cgWJq0rwuvVjDTZZRzl+yNyGHy78BMCmagTfY+
	 gQpqdCC4rAIOfINET85ksNoekHJj/pwoL1n5T9S+JujM610ojjjk6pTFY2SlkVI8tECuR
	 RsSVQSMLwBGETP6dfkPsQ5lZ55CAGaHWzDH/od+8p+jqtagUmzCOBa4fEz3sIE0Sc3tBc
	 hde+MXvzijNsYblfLu5lFdZHy/ZxtPVq2N6oaH0AnEojH8/zR83KlyOYpmaNvo78mjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789846285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8oLo8iD2ynpTXOgIQlueuyOfs2ZccS8WT9SafQqsv4Q=;
	b=ewjJCqwAjxcWgl+/zbCcAQenyzSRjn/Wfh3VwkanZEhNWKuA33vSBppedkP7MOF4f31n
	 eamgMbRZYhlwZVApX4w/yosOiqufR9ca41laI6i+XNyQVnjlKtSpopbuApXF1W7j3DRvB
	 +2z+yUka4HtHyMhmxL8kf+dXvOwa1OIlBaisrhCiUX+DdDjHzTtz1Dwz4X/hiy6EtB6bC
	 5f918c0iumGAKLeqxfWnh9zaWupMlVf3zfTpB32dNgl1hF6RtuAGWOqGAPxq0MOZWTcks
	 LXU3CciKLMj487vMWb9lAajpRTkJ09AvooBfb2pG4ibYXjOXHUYeCNiPqhbCHOen+3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789846285;
	bh=8oLo8iD2ynpTXOgIQlueuyOfs2ZccS8WT9SafQqsv4Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SuxlT6V8XjsiW1DhLeiVgP2kBdnmsBtlvkGcjGz9XmbK5rxQ1mVkCr2mTRqUqguvr
	 6BCI0fcrlwdO0yM+sny8FtXIbs6tbj6D1bCn94rcbc9HmRVIyQbsWRLR4WhfCNsRUG
	 NmFnF6LJNLbBbkfhVOFu3eQKteOumL85ECMDK9MdHJXACVeVAoaqPFDS3MU8KscyAO
	 o7CU4cp/0Z/bkJQ58HMQUsn5l/BWQ9t7/WlwDbCwnvgxegHKqltx2cmxRik8u1Z6Wp
	 tInuZqOXtCxLt/aOo69FZnXkORyET4cSWEEw6qPvE2Y8mKyWSMnIqfmAZykqXsRuk3
	 Aoy9Xqq5BYKiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E175F40AA0;
	Sat, 19 Sep 2026 19:31:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8AD1371
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 19:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9E5460680
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 19:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQFnd3-T7Dii for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 19:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AC326066E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789846281;
 b=popJcX2bUhzo7wnnJM3aG0T1VPHPUe0wB6g9hQBnj1IBwfGORF5r8UShGVq+z+dI8gbH
 W9pECUHnoxg8WXLO2sR3XwRY/GTtbA+tp7PGepamjuHlTMLBn8LT7h1n1wDTWVONJ9hop
 7MdaC6CUY22/dSO5PJcZWGtEA2sc8StAbWT2APKgPCo5n8m7XiuSNWBI1I8uo07OkSJFc
 JbT0T2IYOWGxrJZZCxyD9Wg0+JEiENosCWBZEMRfCbrwhVp0+TjBxhxxIS5kr4GcMzEUc
 8B7sHc6XjVfsduSTx5lU1Gf2hKcYOfLsbm0Gq0jCzWKkTbgh/mMpP+78u10JGeLv69Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789846281;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=8oLo8iD2ynpTXOgIQlueuyOfs2ZccS8WT9SafQqsv4Q=;
 b=kWs5UCRNEc4SF0FTEb4aESp5PR3u3JoukHPWMuEvh8mzsL5PUMCrQPQqrl9xKSf9U/VB
 KuOMKirH4JMzZex2Id+knfZDi6LWRwPCIdrfldapnRVJdBBGiaKNCC2JoaPRW2SKi1lyC
 v102iUYjtk36pZ7hLCx9p6QOY0ydZojZb+EQp5Ors8zxdbid+NyoEx25lD5gKoW1LkOBt
 LyTryfmFstLn1S+en74ta+hZOwdDqRekJQle/a/T6NqcutuVykVRl3NL+qzM9SJOuhwhe
 uc6jxfw0rKZY/0dZpbJ0+EFOt/HhzeMG9HdAwpvVqvi8033wUUzoqt5hsSbt/n1Fbpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ghsIxeqh; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ghsIxeqh
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AC326066E
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789846268; x=1790451068; i=xypron.glpk@gmx.de;
 bh=8oLo8iD2ynpTXOgIQlueuyOfs2ZccS8WT9SafQqsv4Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ghsIxeqhJ71yJyM2ov6g9ByHzMVj7++qOZrpGrL7gH8ZrTP/igj1yF6q2rxmaG47
 mVn8ZQh7Ywx51l4MmdF+S9S6rOtbs4tLNQdPmq5TJsOqzcNfVu+4OSqQvhtyyNBws
 GsOaCDzvx3WLamz3DzJk6uMDi+vxu4SpLMiopobLQQ/l/w4wCO6zdWdB0YNPx8Ozy
 V3IUZVv4m/Rnz/dwJ35c6YgDmRku0tcL629OQxZa4E0ECCoYGg60WYRCTuRv8oW3S
 e1VYvdJX0T+Umlq2uTA2SpoSpJIxdrsS0HuWPEnqF5LMnpWfF40KGycLo5xL5a0+9
 f38qD1ZoIsRsla9kOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1xBsOE0hIA-006KcP; Sat, 19
 Sep 2026 21:31:08 +0200
Date: Sat, 19 Sep 2026 20:29:34 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Han Gao <gaohan@iscas.ac.cn>, Casey Connolly <casey.connolly@linaro.org>, 
 u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Han Gao <rabenda.cn@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_cmd=3A_ufetch=3A_avoid_trunc?=
 =?US-ASCII?Q?ating_storage_sizes_on_32-bit_systems?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
References: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
Message-ID: <A6F0EE08-626E-4D1E-B5ED-E5F3198C846F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AfO7cCBkvBOr6w/IlfcLYPTgcKIzX+PxUj9wtoutrDB3wISFhCQ
 Ols7FkMKY9NfkurVA6nCxd52iVEe251rVbW8wcangct15XCDL4O7n0ymyZ5tTIuZL943etv
 +xvuinnSpNC+2visCRGYQjy3y/ydBb6A5daK3Gz9Kd2Nz9gxxhWCE+VfuFlzC0rX4SVx8i+
 K5AyPaLr+mwB5Tntpt4xQ==
UI-OutboundReport: notjunk:1;M01:P0:Eqh5qGaYHA8=;fbSDWv30D7bEfhLyLdS8HXzT7cK
 +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
 RrnbutKJMtjFUpUi/JXesm8kpACKjurH+7g==
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

Am 18=2E September 2026 22:35:33 MESZ schrieb Han Gao <gaohan@iscas=2Eac=2E=
cn>:
>Storage capacities above 4 GiB are truncated when stored in size_t
>on 32-bit systems=2E Use a 64-bit accumulator and promote the block
>count before multiplication so 32-bit LBA configurations are also
>handled correctly=2E
>
>Fixes: 86d462c05d57 ("cmd: add a fetch utility")
>
>Signed-off-by: Han Gao <gaohan@iscas=2Eac=2Ecn>
>---
> cmd/ufetch=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/cmd/ufetch=2Ec b/cmd/ufetch=2Ec
>index d4b54f77b7b2=2E=2E29ccbf654a4e 100644
>--- a/cmd/ufetch=2Ec
>+++ b/cmd/ufetch=2Ec
>@@ -95,7 +95,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
> 	const char *model, *compatible;
> 	char *ipaddr;
> 	int n_cmds, n_cpus =3D 0, compatlen;
>-	size_t size =3D 0;
>+	u64 size =3D 0;
> 	ofnode np;
> 	bool skip_ascii =3D false;
>=20
>@@ -221,7 +221,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag,=
 int argc,
> 			ret =3D uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
> 			if (!ret && dev) {
> 				desc =3D dev_get_uclass_plat(dev);
>-				size =3D desc->lba * desc->blksz;
>+				size =3D (u64)desc->lba * desc->blksz;

Shouldn't desc->lba itself be 64 bit to allow for drives larger than 2 TiB=
=2E

Why do we allow CONFIG_SYS_64BIT_LBA=3Dn?

Best regards

Heinrich



> 				printf("%4s %d: " RESET, blk_get_uclass_name(desc->uclass_id),
> 					desc->lun);
> 				if (size)
>
>---
>base-commit: 211de43d0f954a00a490220c1aac9db298287c40
>change-id: 20260919-fixfetch-d7aa5b94d9b7
>
>Best regards,
>-- =20
>Han Gao <gaohan@iscas=2Eac=2Ecn>
>

