Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D81EC982D0
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 04:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D68D5810D0;
	Sun, 20 Sep 2026 04:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kmm3g-uDT1fe; Sun, 20 Sep 2026 04:50:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21340810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789879810;
	b=iTctUTPfKlV6/SmJ8qqDFgg5rnjcNKbO5ECmDd3pUuQj+e8GJFk0Y9GVL/6DnRdjwVia
	 CNEZzrpqdKQ8UmyAk/X/mojcLEkLDArT2WuHHpK8hS3kyPn052InyjdlmOJFBcnVP6dOO
	 GTd3o9saP1e1WQYcOPg4HKV4YM4dZ557mWrrj6t97+5NVn1RvCA5Y4vSkcSZnfv9l2Dfx
	 9XUAxTHcDVxfr/oAin6n7+ptSHauKD6KpEaquFzEQ2wHQeymibHTBsdhHViSaAVjdKbVz
	 +AM/PRjiD5T5W6JGav0vIX6wbHO1bRhn0fdazVvtvIDFcdWuc08imzy2du1/T2gqNIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789879810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pgGYX8YC7H4nDLlm2uIRsvF5E7+TlKavyMf0cNqLoUI=;
	b=T3dYXADlqAIkmJUauuCJ9m8WevDfgDSeP22MsV6StAZpwp+drYF6nWs8aVqE3fG+nSkm
	 KAab9sQOf3kLv09G18BbsO9L/WcB7Yx48h1dqEYJC6aInGMb3UuLcvbYLSDW8qOIH88bi
	 4O2Upo1laZeYGIQRrzX6RI2WR3TelnJ0hWM0nqTu+ruSSAM5jEs41rbEY5+71CX83Qha6
	 MdB9eyq3cY7Zx8bShtOTXqIJWM8y0WF1hZ8xyypPcVgZJ7vDw60eG7/GYS4Fw0GYcDcyU
	 LeFpIU+HW64xi8Wzv7ihVUFuwaQw6FB0wGEMop6jCv6hD/Bca0xhiW6Dg+XpMEv0okg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789879810;
	bh=pgGYX8YC7H4nDLlm2uIRsvF5E7+TlKavyMf0cNqLoUI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kUC4/w2qX967yJRbkzIv31twVH+icp6BKRwlJtKD1QFjg/2rccNHAib0nahV61wnw
	 grDfM6VNa7DxwczQxRbHZ7/jRAVYZZGFJaFezU8QU6U28J7rsHh5eug+sg2I32Oi1C
	 uXYCiTUUgsu2SiRqgxFbz8BTPVV9AzSP+LT7hFHA6SP6Yy3JG4nkVUm5Ab+9on3K3F
	 tNH+oLIwrpMpDP6HlJbsuyKEbGB0KuyRTW4Jmhpx+7zHVD9PKNsFN4/I+wkZ7KVnw5
	 csIZzTyOxPZiLgseXy/0BV5hGa3TFW3ZrUvHxUbxVtMfXR2mjG4WNubYjZejFndxqh
	 WUcW79nLqMgIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21340810C5;
	Sun, 20 Sep 2026 04:50:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1B6B3DD
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 04:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7BBB40B28
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 04:50:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhmTAYZr9qEs for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 04:50:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A04E740B12
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789879808;
 b=hxeWeLZXEiQ7EYojMTjhump7PKKMbWnZaJREx6KDfcFf86l+mFRJAOTWyzgVjSjrjjL6
 p+I2wApWt6vFKlgZDF4IC2HkSlh+vKYLpAJAc1kRpCEJkMbHdD0iGM+ytHCoYpvUOpYcc
 q6Cwm3aw8eM8PAhcGLyjFrWPbJiMqLOb5/p4OCyJiGtbTloprmKHDsDi/zaWmkkZwb/SC
 ldmq0sO0ixwg1UduRwdqP2jyWyC7BHx7nTBeYv+jbVPfaQDzV74eIlrNUJy+UrBiNbRig
 6ogEsAfrM7JpHpWZoUgM0HpIWbUJim01+H60ZI87zfmVnHa/2KOkU6q5hg1MfeQKiYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789879808;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=pgGYX8YC7H4nDLlm2uIRsvF5E7+TlKavyMf0cNqLoUI=;
 b=FkplgiFsui4LOX8lg8eaZ5kvZfEQWy9ecLk0IokbExjHPn2H8mxmOzxqB7kLuv72Rm/m
 9XzBBwmEUKTQQmPqb3o7uReM8jbVaGexXYYQkBJJsjMz8T++JIelJ0iY30NFTPPkpEteQ
 4Wsuu/+41sq6guNW0z3oe4Q5jqtcnZ0cMyfUBJ9SrOY0dh8YS5x26YtuEpOKd3RsdUiWj
 cbW74v8g7eWre5136b7g+I8AuYXYURVEsTFMFNqpuQws5CckhHCCd3ppYs05dQaLHh8ve
 JGS0H90WVtq9emlgjNX7/j33gRXyCg9Ldsr7FlmdIxaKx+Sn17CAOrrZimtAi8vOKIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=UsoqiklD; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=UsoqiklD
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A04E740B12
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 04:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789879802; x=1790484602; i=xypron.glpk@gmx.de;
 bh=pgGYX8YC7H4nDLlm2uIRsvF5E7+TlKavyMf0cNqLoUI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UsoqiklDlWR1KgfqO29SlGQxHgUe4npsXpd4tPHyF2JM0AAP6DD/GXd0X0kfDfU+
 ncfFXSO01u5Vumd8EdL/rd+nQnPUfaS/Y0cMldSKOrNj4eW+rPvAGBd6ZMfEbBbCA
 6Lgt0ZRE7LpredlK6453ZKmwynK3NoHa1HvJp3OBSjNvEEzFxT999THa5mBDSOxFf
 Cva3y3wH54nDev7FcSXVv6K/4WM7o3cM5E9VeI9yhcwReq+UlRf2z2HKhc9LdKkuo
 CqQ3uraCTkg52S9eLWIml7Uy5WG6hffEjHxXJxheqxsyADM05253foNTGzcltw/5t
 GSHLqCIwatz/W22K5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1waDFl3hng-00gDsW; Sun, 20
 Sep 2026 06:50:02 +0200
Date: Sun, 20 Sep 2026 06:49:59 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 u-boot@lists.u-boot-project.org
CC: ilias.apalodimas@linaro.org, trini@konsulko.com,
 valentin.haudiquet@canonical.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_efi=5Floader=3A_efi=5Fconsole=3A_?=
 =?US-ASCII?Q?find_vidconsole_when_stdout_is_a_list?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
References: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
Message-ID: <DC5DDDDE-98F7-426F-8461-028C7403C479@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BOeta0bWoE1B+k0d5nhDsL99XSghvsYd3mQbxnkTzgJnQ8vpNg0
 u67gKqaYcAykQgg7shzc4u1peIOamBGgV50PBzXNeGodGvmD24m8Ap2jneoF7CfGs33MXQ7
 SU5KMFHxVd2M/LQ2NvOaPVmzvcJYKLDVJOT9sfdLHLiJi9JIdWHYanktgpP7+pXhsDow60a
 BSmGIy43/QPEFZWroWPNA==
UI-OutboundReport: notjunk:1;M01:P0:e6x9cmZDUDQ=;WaysV5SqngkKMCWtMDoNPCNUvLL
 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
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

Am 19=2E September 2026 23:52:07 MESZ schrieb Valentin Haudiquet <valentin=
=2Ehaudiquet@canonical=2Ecom>:
>query_vidconsole() matched the stdout environment value with a strncmp
>against "vidconsole", but stdout may be a comma-separated list (e=2Eg=2E
>"serial,vidconsole"); match the substring instead=2E

Hello Valentin,

The string match here is used here to decide which output device defines t=
he screen size=2E If video is your primary output, you would place it first=
 in the comma separated list=2E

Could you, please, explain why this does not match your needs=2E

Best regards

Heinrich


>
>Signed-off-by: Valentin Haudiquet <valentin=2Ehaudiquet@canonical=2Ecom>
>---
> lib/efi_loader/efi_console=2Ec | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/efi_console=2Ec b/lib/efi_loader/efi_console=
=2Ec
>index 8d076058280=2E=2E85f1a9312d9 100644
>--- a/lib/efi_loader/efi_console=2Ec
>+++ b/lib/efi_loader/efi_console=2Ec
>@@ -344,7 +344,8 @@ static int __maybe_unused query_vidconsole(int *rows,=
 int *cols)
> 	struct udevice *dev;
> 	struct vidconsole_priv *priv;
>=20
>-	if (!stdout_name || strncmp(stdout_name, "vidconsole", 10))
>+	/* stdout may be a comma-separated list, e=2Eg=2E "serial,vidconsole" *=
/
>+	if (!stdout_name || !strstr(stdout_name, "vidconsole"))
> 		return -ENODEV;
> 	stdout_dev =3D stdio_get_by_name("vidconsole");
> 	if (!stdout_dev)

