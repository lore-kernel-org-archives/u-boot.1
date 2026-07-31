Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01BCC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7121C60816;
	Fri, 31 Jul 2026 15:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-wUFG1m6IC2; Fri, 31 Jul 2026 15:11:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8252660825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785510697;
	bh=6t6Oed5kmfu6gMztvAGUKe6ErL4IkA5kU/ul7enp7r0=;
	h=Subject:From:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VuSqbH1wuVuRbdm04luSpOL2rxKu6TwOb6sYgZslMUkvqV/YfQbLOiBiOlqOnMcZY
	 9S3sCgXgi43n+1f4fEaZc05fmKt3Mw4k96g8dJEyKBbFDUmnexZXtXm6f7SLQYwG0Y
	 uEHDdhtNUz6tbqeM82+auZ9DQx0ggAoepzNPcK7SVUCu+jsO6j31ulslYnJgzT7hel
	 jyc9bAgriZ8GTTo2aadMVxabJt12g4+niFYWDDR6Zpagwk5iNayXengrnfMZCxLjhS
	 RNnX0xiGFM8rJBdHVXQzSeJDzszs6niqSpffSWa1COefBUAti2ymgpF3OsNN8jYmzk
	 KXUHUzaCFlkWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8252660825;
	Fri, 31 Jul 2026 15:11:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BACE437F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B920740F80
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yjtnShMDh7mO for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 15:01:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=richard.purdie@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 579C140EF2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 579C140EF2
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 579C140EF2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:01:16 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so1792047a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785510075; x=1786114875;
 h=mime-version:user-agent:content-transfer-encoding:content-type:date
 :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6t6Oed5kmfu6gMztvAGUKe6ErL4IkA5kU/ul7enp7r0=;
 b=Gzba11XlZCd2LKjmtmH4vGHc8EYpBtfQMEWrIm5KVVUXOvzeUVkjc4uYr+cd9tfpWf
 9XAeC/yJu4slTdaNcA/DDl0wID68Tv1dVn/S8sjL9XTh7VtADIf5ok1aMxp0c78XdqAq
 7gq8tuQY2Hlx8SXWB9MzQPEhIWqsrzjpKF4ukfnaBz02XD3KyTt48WXDhXFKdBbeyKoi
 r8KqRMk7i+ylSVImQ7wunLyIAAZHPi25Rl8oxbyi1UaUwmlU0EAOR+wJ1KFSfOnbj/qR
 iWGJZRH2kfGWnhmyLSQ8BTnuehoOn13zASJxhCksR09OtxG86uLaSVrpJ9aiV5gYbzxm
 KrVg==
X-Gm-Message-State: AOJu0YxdH3LaLBc1a2lbsqats2DmyHsYcj+tHMJvMVzBZmw9KmsiMes5
 vbdUVHi8NOhmMGW79Hmgg1w27N63+lui9/Op+eAWA4RXoltTt8ziTzs8Z1kJeZpJd0svY9l/Qba
 IEpJ0z04=
X-Gm-Gg: AR+sD10+3F25e0ZJ7p9BkPhiGudcEMUU3ttOHi7h/pMNHlSvEJmbazhzZ7KmCCN+BpX
 YSUDfT4qIBBqwECnbi/zOiu9D7JPB/aN9tK4H0CmXczRvYGOlN3FqgEBsnVG9QtkBqz1gAU90Rx
 AXEutHt56XuX7ZcApvDCIxOHWg4sQhJQF4QYk13vXO6EJ+d8MRH5o/z0g5SVvbDtffMSXIVqEzL
 OGQBPzsA7Hp/iBNhlEKxRBldMUq3fAc18SOTRF0cPfU3q1RyiuJD67cThO7tmC1RQNIATTlClmE
 yp4RkC6bmGq8xrJnJv5M8c+A9GIqLEbwOlVStFc9J6GjcqqAX4gEzGke/Y2xGITS1E8vWP275BK
 vogYT+MkBkMql79yfZ91wExkTj/nWv4sj3G9hLzkRE5J+EHfkLNV3/yHbJFIdkbL5Jk++PNGVoa
 RfDLvk0Q4VLWWGC7h+5obDvNRD41PtPuNTookMa34cTe1ZJWapbgl6MIGQpucm4sO5ao9Jan/b7
 JU3EjEPUgfs4BnielDZkJOu1tO3qM4ZnaOVmDmwjf5bCUfGlSGKXg==
X-Received: by 2002:a05:6402:2424:b0:698:3b7c:7e52 with SMTP id
 4fb4d7f45d1cf-6a098d3af3amr1335679a12.40.1785510069682; 
 Fri, 31 Jul 2026 08:01:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7f7b:46f5:a0f7:875c?
 ([2001:8b0:aba:5f3c:7f7b:46f5:a0f7:875c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm1764897a12.29.2026.07.31.08.01.07
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:01:08 -0700 (PDT)
Message-ID: <68767aba94c02cab3697b18b65de848cfadb7a2b.camel@linuxfoundation.org>
Subject: makefile confusion about configuring u-boot in OE (ARCH and
 UBOOT_ARCH)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: u-boot@lists.u-boot-project.org
Date: Fri, 31 Jul 2026 16:01:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 31 Jul 2026 15:11:36 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1785510075; x=1786114875;
 darn=lists.u-boot-project.org; 
 h=mime-version:user-agent:content-transfer-encoding:content-type:date
 :to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6t6Oed5kmfu6gMztvAGUKe6ErL4IkA5kU/ul7enp7r0=;
 b=JCNT3YiaiKFgvlXkdBLZh96eVDlXwFMDH62yYqFVxZMkQl+LAnTyy2PGqutfNFTHgJ
 V3W0mRbmJ+RDbjiMMW38wXoO0xc8INVrqW56GoKC8pFA6MfTMGjX+jLqmxl16PFtUeT7
 oEnts7qadku4VyTPruls0iEJAo2dhTf9TGcF8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=google header.b=JCNT3Yia
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

Hi,

I'm trying to clean up some class code in openembedded-core and I'm
getting confused about what the "docs" say I should do vs. what the
code does (vs. what OE does).

https://github.com/u-boot/u-boot/blob/main/Makefile#L381C1-L399C20
Makefile in u-boot says:

"""
# Cross compiling and selecting different set of gcc/bin-utils
# -------------------------------------------------------------------------=
--
#
# When performing cross compilation for other architectures ARCH shall be s=
et
# to the target architecture. (See arch/* for the possibilities).
# ARCH can be set during invocation of make:
# make ARCH=3Dia64
# Another way is to have ARCH set in the environment.
# The default ARCH is the host where make is executed.

# CROSS_COMPILE specify the prefix used for all executables used
# during compilation. Only gcc and related bin-utils executables
# are prefixed with $(CROSS_COMPILE).
# CROSS_COMPILE can be set on the command line
# make CROSS_COMPILE=3Dia64-linux-
# Alternatively CROSS_COMPILE can be set in the environment.
# Default value for CROSS_COMPILE is not to prefix executables
# Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
ARCH		?=3D $(SUBARCH)
"""

so that implies that ARCH from the environment would configure u-boot.
Fine.

kernel-arch.bbclass in OE exports ARCH and UBOOT_ARCH.

I want to stop u-boot.inc inheriting kernel-arch since I'm not
convinced it is entirely compatible and we need to make changes there
which we don't want to affect u-boot.

I therefore naively changed u-boot.inc:

-EXTRA_OEMAKE =3D 'CROSS_COMPILE=3D${TARGET_PREFIX} V=3D1'
+EXTRA_OEMAKE =3D 'ARCH=3D${@oe.kernel.map_kernel_arch(d)} CROSS_COMPILE=3D=
${TARGET_PREFIX} V=3D1'

This proceeded to break all our u-boot recipes.

I think I'm concluding that:

* ARCH from the environment no longer changes u-boot and the comment is wro=
ng
* OE shouldn't/doesn't need to set ARCH
* we should just drop most of this from u-boot

That brings me to UBOOT_ARCH, which takes ARCH and does:

    if   re.match('p(pc|owerpc)(|64)', a): return 'ppc'
    elif re.match('i.86$', a): return 'x86'
    return a

on it.=C2=A0We generally use UBOOT_ARCH with mkimage, e.g. "uboot-mkimage -=
A
${UBOOT_ARCH}". We then have code which does:

    UBOOT_ARCH_DIR =3D "${@'arm' if d.getVar('UBOOT_ARCH').startswith('arm'=
) else d.getVar('UBOOT_ARCH')}"

to find code u-boot which implies UBOOT_ARCH might not be right.

Am I right in thinking the valid values for UBOOT_ARCH are "ls arch" in
the u-boot tree?=C2=A0
If so, the arm values in that function look dubious in that arm64
shouldn't ever be there for example?

I'm no u-boot expert, I do know something about the OE classes and
build processes and this all looks a bit of a mess to me. Can anyone
with a bit more experience tell me if I am missing something obvious
here and if this is as much of a mess as I think it is?

Thanks!

Richard
