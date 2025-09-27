Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD1CAC5B0
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 11:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64EB8836B4;
	Sat, 27 Sep 2025 13:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PVP7VP4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FCA836B8; Sat, 27 Sep 2025 13:58:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E46183653
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 13:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1758974329; x=1759579129; i=xypron.glpk@gmx.de;
 bh=84x5AVDllMLsIo64uzM3QebK7Cge4uUB61R8TK43YDA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PVP7VP4bdLWBc6oaPKuDJM3XnXHQ9HCgxhyCaWka3KutEcJkOdYHth1mxEulPbTM
 AJW6wP1MIMQ4C0bBECbwFuBDlYNAjXy2ucwDN8ZZsYjb2Uk/OpzAjR7d6KMQX3WCA
 ivANycknI5f1Mg5iHYRNfMmpxkx0d5Qs0bx+rbJm7qm2ee5COQ2D7zrQJoaU52rNY
 /ZKX+C1Lo3lvrvZ+xC1TW3RImLJgc4ZRbPqyJkDFace3Pt6RabY63wHxtNDXszkmo
 krLw3AiPYeaw84fHyKcjbTC3pwL9XH/r34iK4kqaY9i5Jii6v34jBpsTqd17MyL3I
 4lcJFSAKzfiqb33ruw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1uMEuP3s0f-00w9eK; Sat, 27
 Sep 2025 13:58:48 +0200
Message-ID: <0959b269-3aeb-48b4-8954-59b73af5674e@gmx.de>
Date: Sat, 27 Sep 2025 13:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh
 <mibodhi@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request doc-next-2025-09-27
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TxuRm4Qp1D4wkdL5lNIw9Sw2NbCIIoGvVQ7/uBvwduFBDgcCtRm
 mlB5DGRbjLlXCDX6rGu1FdyvVIK3VsW4Ra5jGqLIALsHlk+cNHr84VnGZYBIdcGvZrJ7xsr
 3YGIo5+6XQZuAvg+0dqvO3HIB3S60lhqZlOfdpw85EpcnfZUsOgL0ZRhDJqdrg4Y7FCbyY3
 jvmXWwnWQd8+cAPvyBPhw==
UI-OutboundReport: notjunk:1;M01:P0:rH5yX/dPJkw=;Zi3e8TrZjzxZr8dQmnfhpYK6BqT
 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
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Dear Tom,

The following changes since commit 14b784aaf2a96b0f597b4fc3c5a3b4cb70f1818=
2:

   Merge patch series "exports overhaul" (2025-09-26 11:55:55 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/doc-next-2025-09-27

for you to fetch changes up to 1998334d5afe2a036ba4a85b8ee35e46bdedb611:

   doc: usage: Add File System section and Ext4 documentation=20
(2025-09-27 09:09:47 +0200)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27746

=2D---------------------------------------------------------------
Pull request doc-next-2025-09-27

Documentation:

* Move ext4 documentation to HTML.
* Describe configuration option EXT4_MAX_JOURNAL_ENTRIES and
   memory ext4 journal memory requirements.

=2D---------------------------------------------------------------
Tony Dinh (2):
       doc: ext4fs: update documentation for Ext4 Write configuration
       doc: usage: Add File System section and Ext4 documentation

  doc/README.ext4                |  83 -------------------------
  doc/usage/filesystems/ext4.rst | 137=20
+++++++++++++++++++++++++++++++++++++++++
  doc/usage/index.rst            |   8 +++
  3 files changed, 145 insertions(+), 83 deletions(-)
  delete mode 100644 doc/README.ext4
  create mode 100644 doc/usage/filesystems/ext4.rst
