Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE9606A324
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=URaIjYI+;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=F3wemGhP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14A91608CB;
	Thu, 12 Nov 2026 06:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAV8p314DVsO; Thu, 12 Nov 2026 06:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A58960893
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794463308;
	b=VuaE82MTVMZ95viqFmaKKll8/rLMjoQ4VacA1+X0j7yAPlt1yp2rEoFl+z3zotvOorSQ
	 +Sc2twU7zJCPvsX8bvwv0k5ruxOmGubM9BvF/asQiq2EDNAz3SNYHDXk9K6AcTTytUw0z
	 sdUnBSKHkYQ/EQIfiAyvpHi38opOEMXXd0VpcEq/ygOoMAo8a44K88Xb0bGIbICRlCYL3
	 6N11m3hlTumOaSZr9qnwlvYsF8pbEzf3mHPFljfbPPt9Ws8YGHg+JNOxlik/EJaguVb6D
	 R/7viUb+fbJBA+WF2Kg8UGlRGLDgnodjemk41HfqVdEsuiyv7L8rTgyrPX6TXJsPYwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794463308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BaRWupp1cYJ4pzwazNwprlMu1FRzLJhohKdgFcNyTaQ=;
	b=fmnLlJIUGRW7HDk9SuTfQi9jPElgjj6k08sjnBZ8eroJj7IpJCJt9AzHwub340yZv7Nq
	 NiaQa66D1BAPNwm7K0clmeWuzXzX+hHSp1RejGVt9RJfxsUALDrGPN4BLFq2iu69GYOc1
	 xywUbL6uzScPdyu4+oJAikHAqFz74AWWFGnjudq/V+8tzBw5Aiq5gg2IQoB4TcHT4qOTE
	 0zL3bTJYe/YAOT7VI3o+u61/dUMrIuCEvBpcBh5/VxC43io6LpqOHzNt7Q6NCLQgKlH/Q
	 KZpKhDKnH3nONeKk3U0lS6IXP21NJm8aI22FcFSvjP82/SDMW2vrSPmqXEGOdVfA4rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794463308;
	bh=BaRWupp1cYJ4pzwazNwprlMu1FRzLJhohKdgFcNyTaQ=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=URaIjYI+zgLmbSohzEtCAMOU5HAT9IqbzO9NZBIZbaVOJZmi9GwahAihqy9damM8K
	 EZ7e/zQL6yYESNZxD8Q5bxcxp8nNdlmpS3+/RedvYRdW6xzHhSajkRSM1YvuDQfnm5
	 nRP0cOLgvxRNxsC1xzc7iWupzaNEsWeQvVpSc2Y5bo8pDg6DbiqVBcu5ufv1bo8SFj
	 QVBmuvClvKlFmskBjRnyf7d2Oh5dIevO0kqGN1xJkkEMuSNHI7ek5V+mPlGd/dXEGA
	 34OmC1l99i88GSM6kt5sHgpXqETqIi9p3AkNdRB0mP/Dk7qF4awRJEWng13O4yPyVZ
	 ImgZXHtAL067g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A58960893;
	Thu, 12 Nov 2026 06:01:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8179D7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4F7E815D2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id urkmPF22NlJr for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 06:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51D298149E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=F3wemGhP
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51D298149E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 06:01:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C7DF410E339; Thu, 12 Nov 2026 07:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794463298;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=BaRWupp1cYJ4pzwazNwprlMu1FRzLJhohKdgFcNyTaQ=;
 b=F3wemGhP9s59zo6Ax4/NBm9Bo6AX7D4RLxVDR2qrMyin219m+HzJLhpDEIWT1YGf4uS4X9
 QZgsX3pPuBcFTyuKlVo5Vc2gKEKo5KmkieGkCZmccK6bRHhq5kpKfptei4ddte7xtNpydm
 /yA7E67d5h+0M0d65pQPM1TeiCOdtUjknhCLuUg2bXegX5gIa/XVVT2ZnXEKL1QkyfaBlI
 UJVDxVgadCSrLwgY5c2F+aJvpA/xyefPlSqmkgbo7/RRLJ+JDYIquUT5D0LsmpS+ZJAwBY
 copgeINtCNX+I+rhPiRus6Cf7RjTc8RiNp9eBPCmbBzdx1XYT7fndMhd0cRBUA==
Message-ID: <b8f8cb8e-2bac-a529-1631-dbfdccfc6aef@nabladev.com>
Date: Thu, 12 Nov 2026 07:01:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Ana Bobillo <anabobillo3@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-ubi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Tom,

please pull from:

The following changes since commit 8ea02c99391d2d922810065206721ead2863f075:

   mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-ubi.git tags/ubi-updates-for-2027.01-rc3

for you to fetch changes up to fa836529140bc41e0c50412ee89320f6d54301db:

   mtd: ubi: vtbl: check the size of a static volume's last LEB (2026-11-11 10:28:21 +0100)

----------------------------------------------------------------
ubi updates for 2027.01-rc3

- mtd: ubi/ubispl: harden against corrupted on-flash data from Ana
   UBI takes the sizes and PEB numbers it works with from headers
   on the flash and from the fastmap. The series checks six of
   them that are used without a bound, in the UBI core and in
   the SPL loader.

----------------------------------------------------------------
Ana Bobillo (6):
       mtd: ubi: validate data_size in the VID header
       mtd: ubispl: check data_size before loading a LEB
       mtd: ubispl: check the PEB numbers read from the fastmap
       mtd: ubi: fastmap: check PEB numbers read from the fastmap
       mtd: ubi: fastmap: bound the size of a volume's EBA table
       mtd: ubi: vtbl: check the size of a static volume's last LEB

  MAINTAINERS                 |   1 +
  drivers/mtd/ubi/fastmap.c   |  87 ++++++++++++++++---
  drivers/mtd/ubi/io.c        |   5 ++
  drivers/mtd/ubi/vtbl.c      |   6 ++
  drivers/mtd/ubispl/ubispl.c |  44 +++++++++-
  test/dm/Makefile            |   3 +
  test/dm/ubi.c               | 207 ++++++++++++++++++++++++++++++++++++++++++++
  7 files changed, 337 insertions(+), 16 deletions(-)
  create mode 100644 test/dm/ubi.c

To merge into your 'master' branch.

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=225&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
