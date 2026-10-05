Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF41CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45A2940640;
	Mon,  5 Oct 2026 11:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bh0qDAbutiYu; Mon,  5 Oct 2026 11:48:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E2FB404C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200898;
	b=MYgpAx9pQM91tVULLscy382i3iOJVZrbFvKMJbHpO0Y4JbTHUwG2PMKUeLvFTd551ZTW
	 qVC3aK1nA+4WshKtgOZhcoUcs/jyuaPaBrNpw1DZIfs4UNlYZGuuR/MexC66kFSaETe/M
	 GVEQC3qLWfpP1G0vCeZ2tNycX1GIHrevZq/Y88pboYyjk7PF2g/tp7ZTK+mMQ5/spxTNn
	 yMJMMPclN1vfb/df4M728bVynX0AE8OCQNl3lpYOPxYxwSDHpNHruDWL8p22p0XvoL6hd
	 lZdm/J5dG1hcz8DyT3yDj39edIY4JwqX8+2wzgdsFAmFJAk0DryDTfC89bhdswtVS4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1CLMtq/LkEO7XnuCG1H7DFpO5MqUH/gjYkV61VZP6ek=;
	b=s+1ifvkeoCFohgDIXPwfW1nE1Hr7PSlBV5wyDiAikeZ9UDHU34JpMd5pwsoXD0ZpHEwa
	 kNczszBCgMDFA1W665dhAQJr38oJPD4hzWBZsLe7qAy9+JboQCrJnGseqWcq9MbFSlQJp
	 f7UhNyDAkUXjMKITFe/CnEfHGLEehXJSnKIP27m1FxFqbe/DC77Ugpc4vGHzJZthcCNsG
	 2D/ZHcPGp/rq/GhMT1sJhyr75Fzl1NMK9Kp5JkzqZCcjhIZluUDry5kfdwckfs5rJrikW
	 wMWdYWyOIKWvjmHXuabdV1KoosWNV3o1JeMm5rmzjKmjAuZJT1B2Dmdpd3GLxQ7KQ9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cwIkvTug;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200898;
	bh=1CLMtq/LkEO7XnuCG1H7DFpO5MqUH/gjYkV61VZP6ek=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJPzz/DmXoYrgj5EpwBb3lRHY1c7Ej52G1Nm5AwkbQ5aR7Cj/pSqlgvyhRlMZx8EX
	 nzOWCzzgZDL2sYPdp6uZIWmKXNOXLB4WkfpRwCi2BVgQDwFV3sbp11fdriGR1lg59P
	 jpQ8Xjjg1a4vCljdRkNlEr+70oVL7kbTHCwT4zwt+BY0bVrq9sU/11gBdsi+xRVav+
	 8V2K7bCKz1C3X6uBdLwEgSoyVRU7ILX1cMRDmbA0uT0Iy1QFtm5NWPtg3RDDBbIqb+
	 Nv90AFFvEcpZDdKPSM9Ojrwpl9E09xoa2ee4W5fHQuRkqmfyQoJu0dSg1nbd3Ed75A
	 lYs030ZY/OFAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E2FB404C8;
	Mon,  5 Oct 2026 11:48:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D0FA75
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52E4440608
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQfSOiXIiUHJ for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:46:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 78FD640609
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200780;
 b=XsA3R2grITJ1563xi4Z1gpAplLeaW2ceKFkpEorbJZR4lFM2+kV/TvE3Bv9Sh4e8c15x
 JtxFOMKFeP5BgYrjsS2orJoUSQU6UQ/ImwRtk+xNOBV+xOEU5b4D8VZnHTB4X+q7vX8GP
 8gZhPb0arZ9u78VWwQEC35yFYQ8uEyuO7MtZsOLH9ZjUOSiWfZCYVwY21a4XvcDNA3Rwl
 5dISnky6pCYJ9rX8QgUpoAR28XsYxeyvF1NhL4ayCdNTA7+mlpt7uv0jBAZgyudZkZxvq
 AZNBb8Jr+sJr6o1L8sr8pcDreaA2osPm2FP+I3vD/yD8ssxaZ4bzp3fFTBDiyUVi4KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200780;
 h=Received-SPF:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
 In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=1CLMtq/LkEO7XnuCG1H7DFpO5MqUH/gjYkV61VZP6ek=;
 b=AyWiiR8CqdrLC+TQVVcE61HzRj1QS4s3cQFGUnyN/XM5glNtlCsu5fZI/o1lWg8mfgIF
 OZU2gUsQrlQwJyJT/n6tBwY8J62UW+hmsoCIdgUU0o02Bec2lHQazvTCvR2uj6kmNXG30
 fVkPEy70Lfy5evjUpbEZg9+1yHt70bLb4AurEiQjPd/K4zRtjped51trI2qktgICFozDr
 g4TljPStsBY8QWE4zTaOW+3jacjJcArPqvNWk7mfF2/7upJiLM/WB/Yt2kaxwCO1mQg8g
 QTRkx8H7rlsTrdNne+5JkMcxLgCzPVqGwpVHKRsiw29xLKK4RwgeHmIEYNUfiS/YFWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cwIkvTug; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cwIkvTug
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78FD640609
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hyyJm0XT6z8t9v;
 Mon, 05 Oct 2026 13:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CLMtq/LkEO7XnuCG1H7DFpO5MqUH/gjYkV61VZP6ek=;
 b=cwIkvTugjp1QdXn648cVzLHoex0qkr7A6VqDuPh4nyUnUwHFcbVS5Ebdlc9ybQxBhpqg5i
 T2O3qXnwcZ4gu2kvoJEOjzvFIj1WYzQ9io6ciMU2aE2ZKhHgzGVr+DZk5h0c//4OPeBvLs
 Pf5IvKutPdJUPZFttPDSQknJNgOU+1P+Z7+WTgINd6Qg1qwEVUJhWYPWqyvM953ENoGWqG
 Bn9cqHvtbNSvBQIzRFrXF3QXUmOGMCzOyxTaOn1ttUMJr7o8wvCpxZlGTZqWPTJvp5vx8T
 vA3lpapNpFh10kkH/lkEldtpxGwJwbb2JVw/M49QLS4ck+xXSd0rywWkTFFvFg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH mvebu] arm: mvebu: turris_omnia: Enable the `mmc reg`
 subcommand
Date: Mon,  5 Oct 2026 13:46:08 +0200
Message-ID: <20261005114611.743343-3-stefan.roese@mailbox.org>
In-Reply-To: <20260921075925.325869-1-kabel@kernel.org>
References: <20260921075925.325869-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hxyz47qbz3u8k7m14ni1epui5r9dw7oe
X-MBO-RS-ID: 6308f850669b59f6dca
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

On 9/21/26 09:59, =?utf-8?q?Marek_Beh=C3=BAn?= wrote:

> Enable the `mmc reg` subcommand. This can be useful for determining
> eMMC health.
>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
