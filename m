Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21A606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w4sgT5BB;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=F+SoPcEO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A76F80D45;
	Sun, 22 Nov 2026 18:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fiTSrbRodd1X; Sun, 22 Nov 2026 18:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 310D480D32
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795373850;
	b=APu61hoI0YRbfQkv8vUGNF7uymnrwz0hr2zJFeMnxoUQO0Y2/W4bndMFwIgKTqoDEUZt
	 LNO5b4f2DamRr7NFge4kjcGcTdJjlduCbd1baI7FVQ8yERBqMDkClacYUjGtTqSYDiH3b
	 QoX4AWE6sePMcgLmknAqKULa3d9xjGunuW2iunbibkhnEBFHtCh2UVr+etSlTL6cd4AgA
	 KSPxRJBlqHFmbJSamqHyLfXayvendLR8NnZoNavQz7U2uQQGAVUlN9TrYNJ+BUWCuTaf6
	 gvetZKekfKqpZ3JwYcHtH/oL8QhGLPajN/jktZXq4/cvZ3+MLESLJcehRLGNT5fpaww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795373850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xMXSqVPXd8ztZ1TnY8XUTFaRH1LP3hd0FJgnBN7P8Uw=;
	b=ZoFhlnDNydxuVrSA29nHy9TC9Cqld9hu3ISxfMo1hBuvgTYyEiUjvNXF+8dTKcI/Ruxm
	 +BuoAtRRQQJyOJZLPChLPTfiyIlQTF/zHh9KVVbO97wrH7O2DoIyiR/IDilhfDfTlHQx3
	 FMXpfP+wLr24IY5t6tQctnsmyGSANEQLBSgdoweex+aqYS068x2BMJrBPX4DEAs1vhWbS
	 yQ5OmMy8WhSR5LfzC6QM4O9C/7LLC/xtyewMjNy3Gal9HZUeJfQDCTK1U7J7OSqGL53PB
	 4MicL3WLirNKmnswmAAbHiKmfqpJ9tA8JAHBfvygw3n1Rabw6tUkbMFaSz08NBCOZIg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795373850;
	bh=xMXSqVPXd8ztZ1TnY8XUTFaRH1LP3hd0FJgnBN7P8Uw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w4sgT5BBNkj0TMG1H5EGuvZMQW69hH6uDnjXtKXtYfHZ2pt4YGl7sSFVVCa8L+wzh
	 rit9DxBtOai9unfNEnZxt79Bq1WD2QeBf+b/4iJ/pIWi3sv2YnrbWEZQW/Q5Wf/CDj
	 TKmQv6fuRVX8e4cWsE/bEFOEm2lJIz24RJT0OE4eklUWJyma84zFiUoHTdVvI6JSZd
	 gEwWYNSQVK8k/lhPpsofn9utk2QlzCr7H65Ol6DaycVCC2Mgx+buxhFaYsjTA1hafk
	 rzLNfv6bQZQiSYJJZKlch+I87nivLNF1mBZ+Il067EWZBsewf6jzARL19AQ16B1kPB
	 d+czAvEMgtlSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 310D480D32;
	Sun, 22 Nov 2026 18:57:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 42D27371
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FC9240602
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:57:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isSwGvgW8HUA for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 18:57:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 748EB405FB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=F+SoPcEO
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 748EB405FB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:57:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FC484693; Sun, 22 Nov 2026 19:57:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 133C2841F2
 for <u-boot@lists.denx.de>; Sun, 22 Nov 2026 19:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM2-Signature: i=1; m=1; t=1795373834; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy5kZW54LmRlPg==; d=gmx.de;
 s=s31663417:rsa-sha256:MixgrqPSkcjBNYU8eQpd0VAwulgU
 v6m17pvQajWHnjztN4xyXc8Ivw4p1BhvLBJyQjSlrE8bKNbrf8tikdgH2a2KPASju5LdaVSk+4a
 0Aj9AOw5R4QBWiSVHwjjtYmg8/F6fy2dEeohTlCCKAmhPILWEDRV2hsIBCHxWvd+tddXRI0Rrje
 o+69FgYvfsLSMUnkSKTFfGfLi79mpLrC56EkPNi7byre4++ugVFEFxBp22alzaN+n/T/7fLOps5
 Tcd0sP8fWfXPPVQJFjXTpJysS3WVhSVo9SSVvb3LzESJ7FB6e/Ubg+tyRyS/7Rf7BWbua37fVDF
 hkR43eFwh1+uzA==;
Message-Instance: m=1; h=sha256: tRHiE++QEm31GrcyIod7AFeDVoBmeGzdW7Tjr9ETYi0=:
 aZ8b6hg+oVFScyMDj1vWDUYzSwK+3K2h3zmWpMin0E8=, sha512:
 OypAsOTGXBLQfDJrSI0VxJAIzE+L6YzuTCy9t+6UoiH+y90uY83rzA54RQZiBn8gZLLlC9nEIuollizbm2Im5g==:
 q4PFmD/IL458SPEDkmiesVdLx7hM4pIPOvc71cOyGClG7qV1EPDBRSg6vFfjYinC3yN+bkZ76nTYL2+AUefruw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795373831; x=1795978631; i=xypron.glpk@gmx.de;
 bh=xMXSqVPXd8ztZ1TnY8XUTFaRH1LP3hd0FJgnBN7P8Uw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=F+SoPcEOdb2Rw+rszEqPH4P/vYWpXoTbYzgwaMxVi5st6WUOoKTu/g6d+WhbmymU
 ++pmix/JO7GU5B3+QxEz+NV7WGj10B4pRoNst4+GcK6LAFx+8rua/MKtS7ArpfDwp
 nnJ9Bcl0fozaswdBs9p3Tjh0qHillm+lDi6E39Fc0qU6B5ZXn1MzeQwPkX3JTTbqk
 7XOQkavYCwFjbdkmhHDiJ5TtPgUs0AKhfi1ZjfGBVflxINZX9wU5ps3pOyRrQHFjY
 NUYd3D9nA+sIgODfU6DlAgWe/4k8/EZivi1zSDEMJgdsMHhC9R0GI9H2RAIOAmWq4
 x9PjpAHp8p+5VtCsYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1ybXzz0FeC-010urV; Sun, 22
 Nov 2026 19:57:11 +0100
Message-ID: <5409a437-7317-437e-a9a1-4077762e8fe3@gmx.de>
Date: Sun, 22 Nov 2026 19:57:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Yuho Choi <oss.patchbox@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2027-01-rc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uqte28u7TjfBzckSXIhFbIqylI9hIaHKCxIOXZHm3xumQlk2qlo
 9K1WRjtrRrAeUXBkKl3bjk4YZKxrHmybhqf5R+4qHi+Fl3c4aLb7+GZtak1MFUuu4sQtygK
 8cvOzkLeDxars5VeC6Hj+G0Af+m3NZAJ5tSYpm7DT2g7IYwvl4lIaZLBEoQKQB859K59ety
 Lup7zNgPy0vyIZkbfmztA==
UI-OutboundReport: notjunk:1;M01:P0:HtmLasP6hRQ=;v3+yTGhgaOO3Ax5+zZylCYANoSQ
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Tom,

The following changes since commit e578056c766d653270b14557c2a9d8daec414c1=
7:

   Merge branch 'main' of=20
https://git.u-boot-project.org/u-boot/custodians/u-boot-sh (2026-11-21=20
13:03:34 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git=20
tags/efi-2027-01-rc3

for you to fetch changes up to 3962e2a917128277af0af49445d6e528816edf3b:

   efi_loader: Extract FW version even on authentication failure=20
(2026-11-22 13:10:51 +0100)

=2D---------------------------------------------------------------
Pull request efi-2027-01-rc3

Documentation:

* arch/x86: update link to ACPI specs
* board/amlogic: jethub-j80: update shop link to .com
* develop/sending_patches: add tips for series
* CONTRIBUTE: minor spelling and link

UEFI:

* Extract FW version even on authentication failure
* handling of missing TPM in efi_load_pe()
* fix getinfo() returned buffer size and provide unit test
* bootmenu: fix leak of entries for missing or inactive boot options

=2D---------------------------------------------------------------
Balaji Selvanathan (1):
       efi_loader: Extract FW version even on authentication failure

Heinrich Schuchardt (1):
       efi_loader: handling of missing TPM in efi_load_pe()

Quentin Schulz (2):
       doc: arch/x86: update link to ACPI specs
       doc: board/amlogic: jethub-j80: update shop link to .com

Ralph Siemsen (2):
       doc: develop/sending_patches: add tips for series
       doc: CONTRIBUTE: minor spelling and link

Vincent Stehl=C3=A9 (2):
       efi_loader: fix getinfo() returned buffer size
       efi_selftest: verify getinfo() returned buffer size

Yuho Choi (1):
       bootmenu: fix leak of entries for missing or inactive boot options

  cmd/bootmenu.c                               | 11 ++++++-----
  doc/CONTRIBUTE.rst                           |  4 +++-
  doc/arch/x86/x86.rst                         |  2 +-
  doc/board/amlogic/jethub-j80.rst             |  2 +-
  doc/develop/sending_patches.rst              | 25=20
+++++++++++++++++++++++++
  lib/efi_loader/efi_file.c                    | 11 +++++------
  lib/efi_loader/efi_firmware.c                | 10 ++++++++--
  lib/efi_loader/efi_image_loader.c            |  3 +--
  lib/efi_selftest/efi_selftest_block_device.c |  6 ++++++
  9 files changed, 56 insertions(+), 18 deletions(-)
