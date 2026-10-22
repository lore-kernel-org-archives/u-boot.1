Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9B606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PANUJfEJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bu2rvmRJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8745380BF3;
	Fri, 23 Oct 2026 00:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omsHxb0rzQvl; Fri, 23 Oct 2026 00:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF57A80C25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714386;
	b=qQJmCuPig6Nh/vAZCmggTmeUoSLwwRmI7rnf7I/kzrzAvDEhMoxUI687chrCW/Dh55TV
	 2W/z1djIvmn4H9c35LDbYQAj8Cx1QVMFUfw4K8pvtfGuWEtPZVHzvKBATxAEzYDj2LG/D
	 SGROlEd2hUq7mZal09FBfoe4cX3IKEeGWfI2ASOnpr4aejY/VxnmKijeQqAcO2jWFs6Us
	 +uxIqMynnq7d8fZjMPgaIommn69pVnktEi7CJ55a7XjPnFApF2gXYyPXMeWf688sOJ8t/
	 udbQezsH6ITmos2q+fxH96xy4HvXOsFhJVkQNhjOfdMCmM9C49xRdzsc9QtQ2V8/CcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714386;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
	b=HhG0m5WLQoGtkF/CDsTktrnaTrIPVFxXODqL6AgwxUwfnWPVsC+BugCbLtOJfVQ0HIP/
	 y5J95DdhQqslQDnwrkF4qbvyi6B/g7Tpz42mWhbxwvtyCi2TE88IdRDrMQrYos/yY/dNm
	 KUJgJJqQoHBLtXOokkmY42KvkMztw9718+HScR7fxgCXjzq1UuMHNTKK9npmXNEF0wd2v
	 gp5Q9iZ7BSFzfPMml64oZjakkNzCYNbWlGLanD4JQheuc9Pje7c5WcY3UZJug33x+Z8kN
	 NMpkgxk4a4igY9thRclqLtHkCZR3HWSFHC07lTrebBiSCrwVnfzg7PF2CJgprVI1obg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bu2rvmRJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714386;
	bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PANUJfEJdcV0fJraMr90/bED13+aO00Q3gQe6SpgPnoqIeKmy99u0T/319KSlKsiQ
	 mGEEgeiTK2aovtQZbX1bpSIu0fhZDaUknfM4mPFwHh0XMXhuQAef0KtybLnXl2NQxD
	 WzrRRajsA6xN72T55zxn5D75EXuP5i6qDNN3tbhklbmpMEjhnncjKklZCW4I87XcWi
	 Icxk2EW14qRIfZ1GyujGvnXe1xZYWgkLa98+cWNrSmDcHoRcMEnOO3zIrbjPloIYxa
	 g8/qqX1Lno2hsEvO+tUYjM4RUnc+oEN34fQSa5OWca1m6uC4NuU/Eq1+moUUmI9tk1
	 7gaWJjwMfFWCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF57A80C25;
	Fri, 23 Oct 2026 00:13:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 909543C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 762D481205
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehVRzR15sH_o for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96078811F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713208;
 b=TW2OtyQ7Hy/yryeocMn3ZUmeX96CyX29OD/KBoLM7Rl1G1pRSN0+JoBqpgTmkbGnBq+u
 vLBpbx/wQE2isaNHOAjdJn0Z4JAZ0PWtBhjyjt4A024qtIKSSdQHETbpSfg+kiuvyI5KN
 9W10qBqlfEegfWsajvBGXS3MMJr1uHu6upslCPBlkL3DK4lCKkFos6soZXNrYB0v8MWaD
 oKRUZiS0UpkwFK9n2fl4hnEa66Vs6kn2GPxARuye18c3OGaX2yzFynSVZadKT7LUl5wA+
 PY7JpXfqw4BEtW+MSvaU/ohxgdbAaNH64hwK1FVCgcJLopNXWGfCq3dKz6qSSkfBmBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713208;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
 b=DgIDfuOuvtCtlf5vpBPIQeFs9b/zCVWjyv4Ay7YDc1cw9Bz1pynm5sMlciBMCAoTo10H
 uRorGEK26cOzGhbVdB99pkyCs5E00NeyoxA1pkG9nYMj1SdXl7QhKGlo6nNXnYwOMFhS1
 BDM1a+zbrlV5oE0n9o5FGhJ4ZdV8lETlt+LdV1E3eU1CFPq/shfo8FeBEwf7zzdBvx8/L
 /0e/CzNMyrO7tyOmade3i/f0xiVwU9blXhNv7f/Nokph9cR3nLXz4yqvXmpl4X4gVf5Ec
 ibS1X5CpvFws7+1Hkq9ZNyV+B9/DSSM2m8DkdEctNPZKoB+RAIqYJNMvC0Vv4E/rFgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Bu2rvmRJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Bu2rvmRJ
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96078811F1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:28 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-843a4ca671eso154879a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713207; cv=none;
 d=google.com; s=arc-20260327;
 b=pSfhAXoM60625gH/gEelhBp063K36FbsVauNwUgzgAfExHNuLvws0b6WlZXxIGMYKH
 +kClGs2v2hT6S7PHQj8QBmOgUHYz29ET58GrFcCe1au5Uby0qcH6/YhpwB4mcva6X3kL
 kWO4NWFYfMR0KIn/KS05QWuiRyatv4qGyb7me4H5JumwIvzZZvFYqnihCBhgc5/NOFjQ
 hAi2u8AA63EyxrOmAeUNSSwxlkDafFzWREV9NpzGDICL5gtg+lJaFymuBkDlyxN2aw8O
 nY+8Hn+iEa0tDHiXaMSLkWjr/AdbR6vGlQwPdozlBtC1YaJ5zHHT5ZPmmHlgCTCBIEnx
 jabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=e6oCNHVhFY+A8EhwkGiE9P0jwoM5a1ECYTvyqoxvTLpShbm7ZPko/8eRubBfoAN0St
 yIDHtLmMYF3gWqMlcIrKbnc0DrjFpJlKyk8OkeiDK7lgvzHXBzEreLNcZOItZ/4pJH6B
 04sfbZx3NXRB5uG5On8x/mDKv3EpWUElIBhHQfTuXAdz+xcUNTD5+/+099o/f1NonNQq
 S+CevMVy3EM2p3OJWMdBuSOeeB6ZpVejBbMHIFQO/bIq6hJWLUReejK7rRLNU2vLzVB+
 WCPjFGFqmSdaDEjJGqVhdGu3XX2dmpDZ71VlIFdtJTyk/p7NkpXyFWT2j5GMvHUkSNsF
 sHFw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713207; x=1793318007;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
 b=Bu2rvmRJXLWJ6qpBs01jd3cpjoDvVDmKrQjJqZtWHQkgDyF5/IusAsxj2ZSB0Otppn
 c8eX13ePY53Nl5UzMn+k8BcXG74931U5gMc0bIIIp6SVHmDA8MnYNN4zUgXibGGsqvmi
 WxRudNklxaYjoBE2Z0ae6Y7B8PpMlFD/vcI+82P8K2OzAivqkk8lk60JhAHUdzRUuPdY
 UN2cIyEFSRpv1D7M59ZujgWWdt0reOxINDNYI9B+UjmSHrCnSGfkQDJSyoXcOUDj348E
 fLiWpQdn99TspnKSNq4GnH5fV9ECnVO8fRbhdxFKCcu5OVmjHH/jCNkZZmMsHlaFV9uE
 0j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713207; x=1793318007;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4zwONvEh6QHAvaXhBVG561byn+7dOtKBzuq/77jiAIk=;
 b=QXr2XjSL4agSdvyCxDh4RyiQ9YJSkXn5ZXmvjqxGfWjTY8Tl49SEQLQHluMUv9FY1/
 ivm7pZ0EMtLc0ehgktXDbnlIHCoa/53TpKRHy0qqmzuh+cY/uT3vWp9ifUWSiqOFPFja
 RnVyLJrReVNEhh/ztiLvXcfQtGXa41zUINe61xGnu9/vCgDNAHWNXgwM/8Eyohfoq3zS
 9zgQcOHVbXrjVKllvT3Yqol/G5JmhK6iJiw4kDlN+zBn4uHoWoDC7F4+ogGLRfrqTzl3
 p0ME1Lj0nRtRnF/wBNs5m6y2Vw+SZ+i3YlJ5jGatH85rJ9/qf9EZnHUPzxQMyqZh3uWQ
 u5Kg==
X-Gm-Message-State: AFq9FYIZhAkQXPqi2CokVft3WJgu9L5e2S0WDLYZeHujlEIgLG9bBXav
 RbdnpZG/ShTRZPPsDNMegVr8WCeonYZQz7Vz1CI793u0x4rbioOaFvjimqGbalF+MVuDyjMOAeF
 KtrcHSwBmAWqSuz/2UVsQcTGIgfvMNlecxdQi
X-Gm-Gg: AYBFou0a8qwXC6Ziyzs0T2k8ejkJWsltuKzT4yxO9rlYV3pX157WDbehhEgSbgqIPzO
 awK5IIg7Ek6RkxvmDt7JT/BSyt5dX55Ith5mVz6xRIBhHLSJ22tM218wCDkSae5RTt9EvSzuWBq
 Ub17TMI0O83rY1Nv0yCjeEcu0blwR5ppge6PzMZ+hlXecSryB4knxzxAch13xg8AMCQHhG9dGt6
 CSSS8ISbV/YOn3f0qtfdsba8Q9WfkwgxCYb+/Lby5jk9pbFOWjx6DNRK/TzmDBUyjThTO407jrE
 OohvVZ5AJ4Gep8G/Sewyss2bYDb/Ia/BVotwgzsoErh7G7aa/EUDY8pJMiij9C7vSrXvEpoVGlp
 fmgVr1HtekCu/4Q3DIUfOQbb1IxeYUaI7r0wga0ciqZOL
X-Received: by 2002:a05:6808:5395:b0:53d:c86f:d331 with SMTP id
 5614622812f47-55be80be2c4mr429632b6e.5.1792713207099; Thu, 22 Oct 2026
 16:53:27 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:26 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:26 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:26 -0700
X-Gm-Features: AclHuK8SM0Menq656bepKS3Izhqq1QN_hbDRFpIfSt6sF3RPDc0L_eFe-dxUdZQ
Message-ID: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
Subject: [PATCH 0/6] efi_loader: capsule: check sizes against the capsule
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The capsule update code takes several lengths and offsets from a capsule
and uses them without checking them against the size of the capsule. On
the capsule on disk path this happens before the image is authenticated,
so a capsule file in \EFI\UpdateCapsule on the ESP makes U-Boot read
outside the capsule buffer the next time capsule on disk runs, even
where CONFIG_EFI_CAPSULE_AUTHENTICATE rejects the capsule afterwards.

Patches 1-4 check the capsule file size, the capsule header size, the
FMP capsule layout (header, item offset list, item offsets, image and
vendor code sizes) and the certificate length of an image, each against
the size of the capsule. Patch 5 checks the FMP payload header size;
with CONFIG_EFI_CAPSULE_AUTHENTICATE that header is part of the signed
image, so there it is hardening. Patch 6 adds unit tests for the FMP and
certificate checks: without patches 1-5 four of them fail and the
certificate one ends in the crash described below; with them all five
pass, as does the rest of "ut lib".

The capsule file check, the FWU accept capsule and the FMP payload
header have no unit test, as they need a file system, FWU or a signed
capsule. I checked patches 1-4 on sandbox_defconfig with CONFIG_VALGRIND
instead, by placing malformed capsule files in \EFI\UpdateCapsule and
running "efidebug capsule disk-update". Without the series valgrind
reports reads past the capsule buffer in efi_capsule_read_file(),
efi_capsule_update_firmware() and efi_parse_pkcs7_header(), and a
capsule ending inside its FMP header is reported as applied; with the
series each one is rejected and none of those reads remains.

On that MbedTLS build a malformed certificate of valid length still
crashes sandbox in efi_signature_verify(), with or without this series:
pkcs7_parse_message() returns ERR_PTR() of an MbedTLS error code, which
IS_ERR() does not catch. Vsevolod Kozlov's "lib/mbedtls: Do not use
ERR_PTR with mbedTLS error values" fixes that.
