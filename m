Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C30C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5370B6075A;
	Wed, 16 Sep 2026 17:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PH5Pd6kue6_i; Wed, 16 Sep 2026 17:36:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A2F28606A3
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789580178;
	b=RkYWFFSAaHXcWM9ci5eS/O0NWYA9PqxCP0uImQu/aBp/uSBrXeTJry8Nrza8N77WnkXl
	 ktQ4+UE7PFG3epZevIBFkJ26S8GN++5twiYEhv5AavuRgZktftJe7tjWk53cBppARwWTL
	 S/UObDcZakWGo5tUA3Oo0OIsyW0mDV0o3N4S3muO7qnjRKOvCM9V2W9AkhApk777Igq9c
	 Hn3UdPU9JiT/lWdhkqDWdSdR7PV3yfWhut3oLwZ3FZ13H1TQcHi/NJfAwIC5QkbXsE0mq
	 Lwx4B0TKROvLkG8mYDWHmptwf1By3S5CMduXAoU9H3BhPNtESa2vUd5IoRDTtxhBidg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789580178;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dM8YXZizgYuxMv0dn9K13MBmbEMmKjKrCp+Su6cEkiA=;
	b=YtFutMwJBy38NZ4l/eAww5wAm0A/rwp21CuMs99juMJWQ/4E7SgIWvZkcqLJa42pklhQ
	 dgesIuBOlCY2bbJo+Gs/xjOf4lkY33Z3qGX0wYn/oVt/Cu9pnOVD9qElOwvH49kxs9F4b
	 fJQ8HzikeaoSOy0fmSjJECw4YBEptY99fz6DMwyoiwvhWgEpYgv01m3nuYUc0IXQJONWP
	 NY7F29qbwiseTUwXjP8ZTmvfQZN6iGyjGhDxd9MZfMPBvD2vhYB/VJvel0b4opPfjgVUC
	 J+MVoxai5V8S8HXLZKAsSwVLBOUscjMSxtWxutIyCS4cj/d+YIppy7NGBG7c+dkXgSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789580178;
	bh=dM8YXZizgYuxMv0dn9K13MBmbEMmKjKrCp+Su6cEkiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLpeDJYJKlSau1cPyySFsQ45yJd34AOYG8Pmco5hSJZiorgY7RtjHsqZ1EuYd09Ly
	 SOMlTrCpa6RxhwK9pnvkiyGalFJV7WFZN3siByTzhHt14Os/Efwcg4MVwusl8N4rMF
	 OTh9CsAYA8mUjl6DLQ6aUSBlVfHxozHHhkiePIDXb25YKM5+m2L1ia4/7I9eg97ukJ
	 CbKAjIovw8x4HY7sfoXJs6ZpCM0czQvMQYdMrgkFOLoHQHOeYc6NuCHtCeSMCdTbo7
	 tRBk1J2AJEDLpUhIwchX5w3SzLji4U5nNGD4tNpPd4/RVlGFUGmB4kQd8Ac88zHt4E
	 Zdxx00jP8Havg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2F28606A3;
	Wed, 16 Sep 2026 17:36:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C10D6268
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5BF2406D0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_bVpGeP4soc for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F0E94402EC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789580176;
 b=ABNlZCezBIXhooXaevg40tkCnDrDFo++lDmpzpuX3gjsNwLAjyxIJqJTa432GYazweQo
 avJzQFXfRqfbiPEor6rnd9SpOmDpxad3xTUslnjhvtTEOxu1BlGzs+H9n2JY5nOGHq/Jy
 7/z6zY6pkDGMM2ClkunIByYpMTCmHH+C10ruWDpK1HwdiYn4z95aM9OTah44gtyAJLZc/
 2wWocbs4xX9MT0Xvuaq9jskxNCUXL6iF9EsPNRH+ypEkJVORNO405ralH+Iihs+gy2eHQ
 yY+OveaSjrsCBvpm/DsjBBvO+44JfCxG3EovMMazFZQElW2RjgtzXd9m/1KeIUXvxXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789580176;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
 bh=dM8YXZizgYuxMv0dn9K13MBmbEMmKjKrCp+Su6cEkiA=;
 b=JroMPr1WfayIq6OyJEjMXPaqZoGLuEtnVEzdoE+MMr9t0rG1aN89Hs7lTSV3NZD/wi86
 U/dU+bPEdYdenYf3Pl/dT2L93UZdtB5QdpXqNW+w73cpXCW6007EuFN7EFFlt2h4ZHJ3C
 PMPyowjpStPGqin96C1HuFpTYZ2GPyy5XcfGlLI77UMV7e0aIku+iatONFe4pd+ClNuwg
 Yha93G4bf/xgZsRZ9On6VrIvsI89TKEb69c993TSICJB+PWTRd/0apGvcJbhS3swP1lDL
 5XvYfDl9mmT4uBiXZlX6Z7zXxcx7QSTQWfnNihq3ogt10cDe2kaTnn49zMr3wRzABZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=HlaXC19c; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=HlaXC19c
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0E94402EC
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:36:15 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3997420B7169;
 Wed, 16 Sep 2026 10:35:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3997420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789580130;
 bh=dM8YXZizgYuxMv0dn9K13MBmbEMmKjKrCp+Su6cEkiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HlaXC19cDAKtoVw07I2mSpn1WfJetRVxbpr8DGvxM67sIzG0zu11k5SIFwLqIOEQR
 MtjWrcuyoHds9uzqSP1GIMV2MhZjq6bwDApSfwLELOIjlF9I8cg2DwhdzkgB3NLR7E
 rgwiJPPBHU1RZwaL6jZgciXpOQKbWdTz0JcfTc6E=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Maarten Brock <Maarten.Brock@sttls.nl>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH v2 0/2] board: xilinx: board_name_decode() allocation fix and
 weak ft_board_setup()
Date: Wed, 16 Sep 2026 10:36:09 -0700
Message-ID: <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v1 1/2 ("board: xilinx: Use strlcat() in board_name_decode()") is dropped
from this series in favour of Pranav Tilak's patch, which fixes the same
heap overflow without the extra strlen().

It is replaced here by a separate defect in the same function that
neither version of the strlcat() conversion touches: the calloc() result
is never checked (the test is on board_info), and that early return is
the one exit path that does not free board_local_name.

2/2 is unchanged from v1 and is resent per Michal's request.

Sriram Sriram (2):
  board: xilinx: Check calloc() result in board_name_decode()
  board: xilinx: Make ft_board_setup() weak

 board/xilinx/common/board.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.49.0

