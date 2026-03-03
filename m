Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98075EC0466
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 09:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982E8838BB;
	Tue,  3 Mar 2026 10:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=lixiang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.b="LoQMh7mZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFB183F82; Tue,  3 Mar 2026 07:29:46 +0100 (CET)
Received: from lf-2-34.ptr.blmpb.com (lf-2-34.ptr.blmpb.com [101.36.218.34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A993383F64
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 07:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=lixiang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=suruitong@lixiang.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1772519372;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=RYugzZ1F4CQx+531i/mb5jo3MC3nFy/DhYaz8iTl24s=;
 b=LoQMh7mZPSRWkYXM045K8sni004q+NfDS3xcNFytfnahpGZes3YZGzj8fPk7Hqk/UtMfnu
 q5Ioawit6nZM/EGZK5qnLPs36ZcTzIPs2g4ooBvVsl/xnADrkDKzSnKF9JU9zerTpJ+HZ9
 Bq6qiBEi64XW4lo/+bihQDX7xwkD9qmlWZpMDX/0pxGophGihlagVkOlL4O+25oCZZMvkW
 8AWqgjginOyiYRCWv8071cLDPQiv1OYPBkv0OKNbXIf5YglA7s2Sy35v9bpKJdPC8joRUy
 NV72W/njXKyoh6sW6l5YOTpoW3Ng/wWFbdMI/BQ27n0pQ1+vOjPviRQyk8NVBA==
Date: Tue,  3 Mar 2026 14:29:24 +0800
Mime-Version: 1.0
Cc: <mkorpershoek@kernel.org>, <trini@konsulko.com>, 
 "Ruitong Su" <suruitong@lixiang.com>
X-Original-From: Ruitong Su <suruitong@lixiang.com>
Received: from SSOC4-SH.company.local ([220.248.55.70]) by smtp.feishu.cn with
 ESMTPS; Tue, 03 Mar 2026 14:29:29 +0800
Message-Id: <20260303062926.3335004-1-suruitong@lixiang.com>
X-Mailer: git-send-email 2.50.1
To: <u-boot@lists.denx.de>
From: "Ruitong Su" <suruitong@lixiang.com>
Subject: [PATCH 0/2] fastboot: Add UFS flash/erase support
X-Lms-Return-Path: <lba+269a67fca+1a16b4+lists.denx.de+suruitong@lixiang.com>
X-Mailman-Approved-At: Tue, 03 Mar 2026 10:17:57 +0100
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

This series adds a fastboot flash backend for UFS devices.

UFS (Universal Flash Storage) devices in U-Boot are accessed through
the SCSI subsystem, with each UFS LUN exposed as a separate SCSI
block device.  Unlike eMMC (single device) or NVMe (single namespace
in most cases), UFS can have multiple LUNs that each hold their own
partition table.

The key feature of this backend is multi-LUN partition addressing
using the "<scsi_dev>#<partition_name>" syntax (e.g. "0#system",
"1#boot_a").  Unqualified names fall back to a configurable default
SCSI device number (CONFIG_FASTBOOT_FLASH_UFS_DEV).

The I/O layer reuses the existing fb_block helpers; fb_ufs.c adds
only UFS-specific partition lookup and GPT-per-LUN handling.

Tested on a platform with 2 UFS LUNs (LUN 0 for firmware, LUN 1
for OS partitions), flashing raw images, sparse images, and GPT
partition tables via USB fastboot.

Ruitong Su (2):
  fastboot: Add UFS flash backend
  fastboot: Wire UFS backend into command and getvar dispatch

 MAINTAINERS                   |   1 +
 drivers/fastboot/Kconfig      |  30 ++++++-
 drivers/fastboot/Makefile     |   1 +
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_getvar.c  |   6 ++
 drivers/fastboot/fb_ufs.c     | 164 ++++++++++++++++++++++++++++++++++
 include/fb_ufs.h              |  49 ++++++++++
 7 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 drivers/fastboot/fb_ufs.c
 create mode 100644 include/fb_ufs.h

--
2.50.1

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
Disclaimer: This email is intended to be read only by the designated recipi=
ent of the document and has high confidentiality requirements. Anyone else =
is prohibited from using, opening, copying or forwarding any of the content=
s inside. If this email was sent to you by mistake, please contact the send=
er of the email and delete this file immediately. Confidentiality and legal=
 privileges are not waived or lost by misdirected emails. Any views or opin=
ions expressed in the email are those of the author and do not necessarily =
represent those of the Company.

