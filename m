Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167D606A326
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x4goXPCr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa0bRglS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C562560A6A;
	Thu, 26 Nov 2026 13:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rI8nvvX1RB8E; Thu, 26 Nov 2026 13:06:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E31C360A59
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698392;
	b=ODRo9ha0PKmzzowmoM0pLwDxKqg0KTidf+VlAX9Ft70FB9g9uZrC21lfjoCpRvmn+4aX
	 /GVvIrzWuzKMrjf/wQalEx6uQ2cS5cakNj2xN6hvhBZZMsjl/jCaU7WkVZmi/zvc2g1Yx
	 Sl27/oHvtiStdz1Zg6kK2si1Rzh6is1rO/Z0PhiyRBGvsxjtorYw7ddluUju6lE/G/x7i
	 piJkVcd831uAjfjZ2kDDftJk4Yl8MsKmCgtDPW6D7Om7MXpQlWlsDHsNdY7q17SXZ93qA
	 RTckVV55GNBQChps/alXf0FsbM+KKbZ3ffSdkxdWUoWoBivSLhA3TnfQUv6w8xGdSww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SDWcclaLO5uEF1U7RiaAv1N0KE4qWuyI6UshCPK9Z/Y=;
	b=l34Dk1TBSgb6kB38/Abg0xDcaPXfnVl7TduIk7anNAROiyvQRx0ViakdMRolta6KHEa6
	 eFZNUvJFMfgrMrM+5EJky14Nj6k44zzoMWnIJNq9Mtatjg5eU4xgOcquRVVUp388tvkBw
	 stZZBl4alvJnBwHKNLtOI3P5mbWUVHgFhhGI65boOFSxIks0GrEAYLkAQlct6QODpfhzH
	 2Ww9enl8BR1GMBL0PCSodq1JGbTV5Rlvfa5d6zK4OSQhXFwB4ceV+GV0ihUQLyLCB+pf4
	 bLkVV1MwYv7ITuej+4mOUG9wi6B8qn7+SGBhc3kdeSHtV24XGc1G2BE/4KFHHRphmfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pa0bRglS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698392;
	bh=SDWcclaLO5uEF1U7RiaAv1N0KE4qWuyI6UshCPK9Z/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4goXPCrx/kH97T7sC0DSkeY0nbWWN5jQJdvajDCoinHWbjrK9cyS2uB0JSLhZ2k/
	 ioC8w4SdLwsGxZ/jR2XQRGGlFLy1YGlcOov4KHj6n2/CLVzIpbD5Wl88zhODKhQhWs
	 D7PupAnjzTzLlLvPXgWpIlzFBGI8rjUtdr09vJI6rtq43GM8FfkGqlzSawW+8bTKDl
	 DVz3GceENiGLpERuYyKEHpTj9byl3vNoh0FNEEovRzNbvgpuxeoHlmOkRCE3DyvIzV
	 TgnJvJY8XHNIfwVaElx260WLfUqreptg6KsQvaycNs+ryB1sqBYdE5iLTTu51wkFo0
	 cxdXk36QAHotg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E31C360A59;
	Thu, 26 Nov 2026 13:06:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80C932DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B7160A59
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xTpftSmhwxeC for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A2862608DC
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Pa0bRglS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2862608DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:06:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4FD942B3E;
 Thu, 26 Nov 2026 13:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C5D1F000C6;
 Thu, 26 Nov 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698388;
 bh=SDWcclaLO5uEF1U7RiaAv1N0KE4qWuyI6UshCPK9Z/Y=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Pa0bRglS2CS4X396ZTMzvCXd8ynoqmh0YfNJ/ZuzqEPg1QsEbZ82UK53mGda0/sLW
 KpTLn9xbBvltzwvWPJQ8cHbHhhx+ka7gU0AzrnPRbxEnIQ/y6YtgRUq1YeHc+x1cm0
 bL7/Ao4kBuXZGBTzIeXMGRVbuT9AD+PxDxo8zh05vE4Tu1rJwf9TBCla1FrE1hx2TH
 6HXnHVe9fR20oFRr1TGKo8WnWUS9rN0pPtc/SdQy6FCx0e+6yYOTm4Ipc8/dkuy+5O
 fTC8Lf7ELETVPSpBgOeq7m85m0vkDP+YKol9BPSyvWerX753tfRMiq7EYHc4KaUfKq
 BlLEpri0/jt0w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
References: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
Subject: Re: [PATCH] fastboot: spi_flash: fix getvar partition-size of raw
 partitions
Message-Id: <179569837571.2171115.3700927477205546828.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:06:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=434;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=/9Hi8sV4N5PbvOhTUoob15FolNkfuZ4K0QiZrakNnOY=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCC7S2MfbABkvEdqJcD5Y/H1n42SzzphN0btLZ
 N8b5T3B++iJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgu0gAKCRAZDR20Zk4Z
 NUhECACGYaRFwq3Br6qgRlE8VV4pXXkHPS/Cr2UQG4M3jVNCsdBukk0YXRIE8qvrz51lLwNphhK
 XMT4QMaBRnRT3bIUiqbsCsAI1daTPuuwgF3RMUkceHCZROaa6zDKdlkzWJYGQlYuPJT2iEGYvyJ
 YD0UCzhTyoWcSVLEydVKPg+mfjetCxiN/KPAfXG+HaGOTAYfnhK6438lIaGWgURS6BlSbXqnU1j
 lURTe/TCajfHqA/Ec2IcjA8wA82HihL9iOPQEMzNDZilp40GMLfQ6/r5YhCQ1P9V0jvOqQSw4y9
 k/svBnjdxmS9Nvl96WXNlGS1B6MvH0B98XiU1COqNYmQ0odx
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 17 Nov 2026 18:21:43 -0600, David Lechner wrote:
> fastboot: spi_flash: fix getvar partition-size of raw partitions

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: spi_flash: fix getvar partition-size of raw partitions
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/2ae8fd2a165196fc84f4feeec306e9b69962fb3a

--
Mattijs
