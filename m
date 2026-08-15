Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7E5C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 20:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04DA7407CF;
	Sat, 15 Aug 2026 20:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYIipEr7-caM; Sat, 15 Aug 2026 20:05:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CFEA407AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786824313;
	bh=RgWWmdgwhBY8QKtY7uoB1ipD9W62ZHFyXi4bgJ0uVqM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXSXjiWtlgOoQzTWDGfJTCLbo3n7/N2daSae5FVoJmIIdrlX/Yl6S7R2eoMH797VT
	 EIWZb9Ujyvn6qoT/ow2LKNGlLcom/ts+gtnjI7hkxlHMssBzkAfwyxSepyKkj1mwri
	 tx5oAcI2SZiT3/7R1OpJeqUpmfbR9x4+ohZHCz56kTx36HpDTGOORhxWK9djyMa9PT
	 +HHiP/5qCo7lzF0QI2foR8oT1ApA3seHjYW5a3HPyrFA1fZxjohAO9ahSqrwPYZC4X
	 eAItnBBdhh8CKayMGCXso+Aj6jcdLrmcCZHK0PzpqJ1Vz8bQvlvtQwyAp/wKu7Ogcz
	 m8KXCn6NuzQWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CFEA407AF;
	Sat, 15 Aug 2026 20:05:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90BAC334
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 831C76063F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wtme4dEUP_WZ for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 19:44:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::929; helo=mail-ua1-x929.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 40143605E6
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40143605E6
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LpWq2Rq+
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40143605E6
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 19:44:47 +0000 (UTC)
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-97bf8f6a31eso451452241.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 12:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786823086; cv=none;
 d=google.com; s=arc-20260327;
 b=AgS6SHov4UFcjQxkL92ZImM5eQlSKB7nhQxzot9IpqevHPrjHvs+tbAAJFqde0+DUs
 UaMyqAHY/m6LCy23Xu8QOMFGgQsTouW05P42P3gUDXU3GZrvXlrdWokIK59KH0oNQteW
 na9qPdsr9mS6PeNkvITCNAuFceuA0pWs81aB1B5d3j7aPVKJ7LMQ4aLr7RCyLmCxmauc
 ndtt+L573OHwSaxd1CNsN9Pi5Kr/g3X+99dDRc4z6/d8TzlrCxie1kOIwaSDsrCffZQY
 GYhyPskSEb5OniAPOtRNvhy3VdZoXpSmObPyNS3poplOEQrH1qDuV7L8Bh6rndq/6uxz
 f4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=QozyvD3peM26WCnTiZT2OqoF5THu7syw1NCSap/W1Ho=;
 fh=5Npx3k9b5z47XKiJBELwPu6sioz5jeS2G3yV/mI266o=;
 b=jWI5DH6Pj41QaoP8aMm64SDxMnlba7s6TMG6ZfXnnBqr94f8STW7cHJo1BBRsVhEc7
 lBsqHZXrM23CEfygIxqgeOzrbh+k7Nxc5XBTK+fD875kNenTZhyysgCCAS5WGSLsCpF+
 hYy6gOiP6rXwMcS/86k0RmNnUwMbDDLQMM3DfgDQMFmz202snHMYEknxIpr7v0vFDz6p
 Q4WWvzHsBkYZqBWyrE+iTyYa6ssYx+UelyzI1SB3JMtF0qJUPSivF/HYS7c7HX3J8a7w
 Pziw+Fh6q1oNovDWr8C5WwVbJNT2Mc0wLLyQClSpSoNQjSylVvGz4GVM5pg9u4DJsQ8o
 2F/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786823086; x=1787427886;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QozyvD3peM26WCnTiZT2OqoF5THu7syw1NCSap/W1Ho=;
 b=LpWq2Rq+TipjOTUtJCTiwRJcGtilEYc/4U2HSdIU/lPOpuon2An4d/N2bTobT43+22
 6db3fbC5xdAk7YDkzNVsR7aUE+tPSQGaOSwZOnTEMjyG8NAEY7Lars/uVP8/VnE73VSN
 yIWog8c70a1AXcszl4HauKPZW+bXOGcL5WdQIf2g+Uvx9jUU/+0JFM0ETe+/haynEwsb
 KK+0JvejaQn3lcQn18ba5Ek2y7ovicSrDwAK+l2PCz54QURROfoVuOMq+o8/rQXjXwvd
 09zjfOXboR2KsTx6QWPHCe4cwNQr8Q4ONrhZ/8Dm93ATiJzANSjUZDyIY0B4WC25dhzO
 g99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823086; x=1787427886;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QozyvD3peM26WCnTiZT2OqoF5THu7syw1NCSap/W1Ho=;
 b=chwOPQplwzTLsdY5c5ys239Tzmo3w5PZinI0icu/RjiKGFeOe4yIGfes2zbT82MQKm
 RBzzCY3EKoBCtcCaBuut8IbBNHFXtnYS96XQA0o0kWiibg7uizv3hOZlp2vGpn+F8h+i
 YThoV3/9BCNMrQuL26VV/Bk8sRzJg9mYKpJB1N1MnogzlrxqJnOeQ6YyPIhJcZU938L0
 T8zZsVHbR54RkWmXL29KIGEl7OUW78oov8CNEIeDTXRrn0i+UFOTR40XVZ7GrChI8fia
 2shdv3hT3kM2Gq9qHMFHvtr0BqXAC9YldjKlBeezSIt1oyEMDBLShxf/OBF91DwPCMTD
 NcQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRqnCxCSd7r7OFKjLZW9vLXhnPWkTuyadm2M7CDDGh/mKvXgyGIok6m32S2fWv9JMesr88Xto=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzzVGSYMKU7NqUGADOtO2MWNsULyTKj6Q8Csyw4vLpSyXEtZz9R
 vT7RZD1KNPi8Z4oEAb7ADXtPQ80Ez9L7MeBdZBMGQ0W++askj0bW2jh7BVeArzRR46Q59aNcrdK
 ecH+GtRFMwXquzzugOux2LbIZpXKd6mIqAapkfNQ=
X-Gm-Gg: AR+sD108vzZiCuS7gLEMz4DtidgDBTpd+jg1QnvkbJ0Wk7hA4+30YtYhx2Zd3kk8O3Y
 b6oTkemEDlrY7HFPjiZm7XFuq2HhDQo1/Dm3xMW/p4LEoayTaKyvxTDZsb6S1qKu21+H6TwTZuh
 UMkV1QkW9BuZCCbmZqX98kp6dDyo9El3mD72Haw0cs0YljJzQBqEztcYPIxIX30Rhh4xnMV3fwK
 aGMQY67YocXyHPW18NT5n3p1zkHtsxhkikUPLd5Pp5GcpCXzboyVyUjcuM2/gssqHh+IvWCoomk
 8yZU1M5PcaUSzgt24vIJDodeoounYsZg6b2e8EYpIrT/BErhO/WtKknpnMNeF1yfTAIuucYG6vk
 QC2VhPMo/GIaifJ/GflJbGxo1srOZ
X-Received: by 2002:a05:6102:5e90:b0:76e:e529:2fcf with SMTP id
 ada2fe7eead31-76f2a9eeef3mr2230460137.6.1786823085833; Sat, 15 Aug 2026
 12:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANMPf=M9ZsryW_doxe7Vrvd4atYpFgctR4e_aE6xjRZWDa3LYw@mail.gmail.com>
In-Reply-To: <CANMPf=M9ZsryW_doxe7Vrvd4atYpFgctR4e_aE6xjRZWDa3LYw@mail.gmail.com>
From: Pranav R <pranavkasthuri@gmail.com>
Date: Sat, 15 Aug 2026 20:44:34 +0100
X-Gm-Features: AcwNN1WhN4mM-p7Z7CmVOAv6FF-V2BRPaQQe9pW536_Q5mgD3QVEKy4MX_MEfdU
Message-ID: <CANMPf=M-XLJuw4OM9C+xFCB03DByWvyin+_iFOMyrrSXSjqYfw@mail.gmail.com>
Subject: Re: [SECURITY] Five vulnerabilities in FIT cipher, squashfs, and
 BOOTP/DHCP handling (mainline, VERSION 2026.07 dev)
To: trini@konsulko.com, u-boot@lists.u-boot-project.org
X-Mailman-Approved-At: Sat, 15 Aug 2026 20:05:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
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

Hello Team,

I am writing to follow up on the security vulnerability report I submitted
on July 23, 2026, regarding the five memory-safety findings in the FIT
cipher, squashfs, and BOOTP/DHCP components.

Could you please provide an update on your team's verification progress for
these findings? I would also appreciate any visibility you can share
regarding the remediation timeline or planned target dates for deploying
the corresponding patches.

Thank you for your time and continued coordination.

Regards,
Pranav Rajendran


On Thu, Jul 23, 2026 at 11:56=E2=80=AFPM Pranav R <pranavkasthuri@gmail.com=
> wrote:

> Hello Team,
> I am reporting five memory-safety vulnerabilities found during a source
> review of the current U-Boot mainline (VERSION 2026.07, development tree =
=E2=80=94
> happy to confirm against a specific commit if that's useful; my checkout
> doesn't carry git metadata).
> All are static-analysis findings, traced end-to-end from
> attacker-controlled input to the vulnerable operation; none have been
> exploited against real hardware. Detailed reports with reproduction steps
> and remediation suggestions are attached as PDFs.
> Summary of Findings
> *1. Heap buffer overflow (write) in FIT image AES-CBC decrypt*
>
>    - *Location:* lib/aes/aes-decrypt.c, lib/aes.c =E2=80=94 CONFIG_FIT_CI=
PHER
>    - *Description:* A destination buffer is allocated to the exact
>    ciphertext length, but the decrypt loop writes a block-size-rounded-up
>    length with no alignment check, overflowing by up to 15 bytes on
>    non-block-aligned FIT image data.
>    - *Severity:* CVSS 3.1: 8.1 (High)
>    - *Attachment:* U-Boot-FIT-AES-CBC-Heap-Overflow-Report.pdf
>
> *2. Heap out-of-bounds read via forged FIT data-size-unciphered*
>
>    - *Location:* boot/image-fit.c, boot/image-cipher.c =E2=80=94 CONFIG_F=
IT_CIPHER
>    - *Description:* The post-decryption size is read from a FIT property
>    outside the coverage of per-image hash/signature verification, and is =
never
>    checked against the real decrypt-buffer size.
>    - *Severity:* CVSS 3.1: 6.8 (Medium)
>    - *Attachment:*
>    U-Boot-FIT-Cipher-DataSizeUnciphered-OOB-Read-Report.pdf
>
> *3. Heap out-of-bounds reads in squashfs sqfs_frag_lookup()*
>
>    - *Location:* fs/squashfs/sqfs.c =E2=80=94 CONFIG_FS_SQUASHFS
>    - *Description:* Two independent unchecked-index issues in the same
>    function: a fragment-table index derived from an attacker-controlled
>    superblock field with no bound against the actual allocation, and a
>    metadata copy bounded by a fixed constant rather than the real buffer =
size.
>    - *Severity:* CVSS 3.1: 7.1 (High)
>    - *Attachment:* U-Boot-Squashfs-FragLookup-OOB-Read-Report.pdf
>
> *4. Heap out-of-bounds read via unchecked index in sqfs_dir_offset()*
>
>    - *Location:* fs/squashfs/sqfs_dir.c, fs/squashfs/sqfs.c =E2=80=94
>    CONFIG_FS_SQUASHFS
>    - *Description:* The function can return a negative error code or an
>    unbounded offset; all three call sites use the return value directly a=
s an
>    array index with no validation, including a negative-index heap underf=
low
>    path.
>    - *Severity:* CVSS 3.1: 7.1 (High)
>    - *Attachment:* U-Boot-Squashfs-DirOffset-OOB-Read-Report.pdf
>
> *5. BOOTP/DHCP option parser scan window ignores received length*
>
>    - *Location:* net/bootp.c =E2=80=94 CONFIG_CMD_DHCP
>    - *Description:* dhcp_packet_process_options() scans a fixed 548-byte
>    window regardless of the actual received packet length, which is only
>    validated down to 236 bytes. A minimal-length crafted DHCP reply cause=
s
>    stale receive-buffer content to be parsed as option data.
>    - *Severity:* CVSS 3.1: 5.5 (Medium)
>    - *Attachment:* U-Boot-BOOTP-DHCP-OptionScan-InfoLeak-Report.pdf
>
> Technical Context
> Each PDF includes exact file:line anchors, the full exploit chain,
> deterministic reproduction steps, a per-metric CVSS justification, CWE
> mapping, and a minimal remediation suggestion.
> I understand the project doesn't operate under NDA; I'm glad to coordinat=
e
> on timing before any public write-up and to answer questions on any of th=
e
> above. Let me know if a different reporting channel or additional
> recipients would be more appropriate for any of these.
> Regards,
> Pranav Rajendran
>
