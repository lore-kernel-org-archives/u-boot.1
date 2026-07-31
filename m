Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0497C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C21B240FE7;
	Fri, 31 Jul 2026 12:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNpFtz3EU53F; Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 484DB40FD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785499691;
	bh=6WcfcoV+WSuMZBXk3AlId9Cmth9prnQL0P/uOgoao0E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pb7ibnHLM9s/dzShbL8uLX5ZaXqfwyjdrknOKiR+w/glin9L5hMNnqvb/NsWlC5RX
	 lXJbL56BnUB5IsHpdl3xTslYjnxw+xbYWlWISpA9FoEkQC59LO9NTZENtOGRjEZEqh
	 aZL1NAJRI5q7GB93R8yW++mczsbGzWF1XIGqCIg/kZwgoEYPG7oZUe51VqkTU9vghY
	 LymdcXOIzLBjMUpL+65QuxcsprOHy6+b6CIrVclRVpPsCJ4oEubZCYQlS5PK+yZOvJ
	 nkz9COk7GkFd4IDJQAaG8auVwGVLB8Y5lerBfp+7BDd7X+tXg+Ev+Kahjji1FB+9hz
	 XGvJRIhZg6YHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 484DB40FD8;
	Fri, 31 Jul 2026 12:08:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40FB427C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27EF1400DA
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7x9uzJQwVCa for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:08:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EA2CA40463
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA2CA40463
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA2CA40463
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785499681; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DpBCNcpjuHWbQ1DnoeIQQoCrgGzxAz6cZHEaP76V3t+WdmHHmBwZkyuW8lxRlfoQ/qAf9nJG9kf0mF59JV58NFlHGfIAtKl/btZCCGjmnm3eEqRz3ZXnPk1hsTg58ou7pWraCAZgirEknzWH3ZqFJ1+2Ervqha94L/RdUG1kqd8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785499681;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6WcfcoV+WSuMZBXk3AlId9Cmth9prnQL0P/uOgoao0E=; 
 b=TmhD6gvoY61YCR4Lqt4+fxbuqJXTaLuAG689TK5azW+uZkMO57piE78Y9qJFD07ohKgV+OejMm0NdBMrWj96GBp0uH3jchh1ft57yPEMfuU/vUhQFSv0OIao87A2MaB+XO6EpUN21XDaCYQH5kBlv0TDwN+oMq4L66HUGYJZJ2M=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785499677495658.6762007434025;
 Fri, 31 Jul 2026 05:07:57 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Subject: [RESEND PATCH v2 0/2] Add LoongArch support for CI image
Date: Fri, 31 Jul 2026 12:07:48 +0000
Message-ID: <20260731120750.2212394-1-me@ziyao.cc>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785499681; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6WcfcoV+WSuMZBXk3AlId9Cmth9prnQL0P/uOgoao0E=;
 b=cNd22dmyVL/FVdBjYTGYfJo1+elqZMJwIoocG2qfbls8KiC0HQmgKyyDJ7/pDjG0
 5FPA1UuYCo2geV78hnvEpchNWje3RyalMgSaEnulQyHxu2Rf/XP91uEu4K3MmKWBoCB
 qttgBzMPXNn6cmyMsme3mFo+N2f/KykhRXC7HK0s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=cNd22dmy
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

I somehow forgot to cc the list when sending v2, sorry for the noise.

This originates the series "New CI image and fixes" sent by Jiaxun Yang
back to Jul. 2024, though only one PATCH remains since the Ubuntu image
used as CI's base has been bumped to noble-20251013.

I also found the upstream added new dependencies to swtpm, breaking
docker image build as we build the latest branch HEAD instead of a
specified version, so in this series swtpm is locked to v0.10.1, the
latest version without newly introduced dependencies.

V2 of the LoongArch support series[1] passed Azure CI[2] with some
fixes and the buildman support patch[3]. Thanks for your time and
review.

[1]: https://lore.kernel.org/u-boot/20260701111808.870705-1-me@ziyao.cc/
[2]: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13494
[3]: https://lists.u-boot-project.org/pipermail/u-boot/2026-July/627018.html

Changed from v1
- Drop patches for bumping CI image to Ubuntu focal
- Lock swtpm to an exact version
- Link to v1:
https://lore.kernel.org/u-boot/20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.
com/

Jiaxun Yang (1):
  CI: Dockerfile: Add LoongArch64 support

Yao Zi (1):
  CI: Dockerfile: Lock the version of swtpm to v0.10.1

 tools/docker/Dockerfile | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.54.0

