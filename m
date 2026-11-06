Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E4606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ewq0hZ5I;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9tDrIvL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 869A2608A7;
	Fri,  6 Nov 2026 14:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JYA-z1DStGn; Fri,  6 Nov 2026 14:15:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73EDB608A1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793974545;
	b=oZEuBGGEiccqNCbjjW3my++/0wImdbdbaEnBjDxS+hXhy/9c6zR+5IlQtZI6MixKlpl3
	 TNIwkQTYNnxD4XrXbLwSIWvZSyRfjZBJeuBXmP5z0JIA45rabTAEapdST8H26gnQsv/9O
	 1SLUBa0sWOuwZ3iUSlMGRY1dn0r6pz1+9D/+khRXi2OoTpMy17RTjxiWLvYKxJIwTPJ1c
	 +viJ/6sa7GDvfqgEG/h6twBC1/4kaVyPkHDUts6nxKCCoqbpwczUEt3RDgkLHYXstLKqg
	 BvP1r8rffPWK0n7jbCBDIFVASOo1n4nI0tjyQqTW8/Qsg3k9VJVbjJzPZz0P5+rbIPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793974545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PcSufziCID1rmqbEhLTUU0fU5Wp2ilIqJOTP4snCy3E=;
	b=WuDjBn99YOMTDSsWB2da9EUXeVG2PqYiWZuEUs5Mb7ZFyD3n8P7VYiEo4KSQ0jrGeELV
	 8RZPYnbVFbzFpuNDNUFOS0s3hHgujtjvNEdx6qO7ton5ApIUz4f1jzHrEARLv381pD+XF
	 et2RcN0PD1F27FwYSa3tbryMwmMGR6f7YMdpVBne11au+oMamtdype2pYAe7kmSspip51
	 3TfdA1nsLRC3Hm3ch5z8Sps6clA0/0fF7SxhHTrv+o7TfUweMpiPCqjZYawHVK88nrzuA
	 tAx6pzLnhrRSV9fSyhWDPySIL25YqkYlYt35XMYxxsKf1d9D1NXL4TMSfP0ybRgveJQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9tDrIvL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793974545;
	bh=PcSufziCID1rmqbEhLTUU0fU5Wp2ilIqJOTP4snCy3E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewq0hZ5IwMMhPKCr5V8PkIW/SGFMFzsuAd+11E3GpW6Fc5RWZDWqrIP+oQKyWMekc
	 MEqKTKOCNV/nk/n19xgEey7zihubK0BqY6uMYf1REfARb4leOo3STCOMdkRXud3fwf
	 iHAhZkBROIoKdAtNs9IZl7Gtwxqg6XknmfCb1Am0EZRZ3scqD6du5/ID9jxkBVb3PN
	 NydaOzwqkPVek2RoTo/BTTjlg6BGSusJK4NwLWYHGmPY4Br7eLPREfLdkLAtV6HF2a
	 miHiBN+qA5kifAuzOsmDCTnosIQN8c6euvOk+je4meI+cAAGcfULd+ISUtzjWRPqLh
	 QyRiitD1zBobg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73EDB608A1;
	Fri,  6 Nov 2026 14:15:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2D9B31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4322608A1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B-5VcjPMliFX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:15:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96F67607BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n9tDrIvL
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96F67607BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70CEC42361;
 Fri,  6 Nov 2026 14:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A401F0089F;
 Fri,  6 Nov 2026 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974539;
 bh=PcSufziCID1rmqbEhLTUU0fU5Wp2ilIqJOTP4snCy3E=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=n9tDrIvLu9kBgahttPi0WM/AnVCeAuBMrsOxfpo2jatavjk6mrdV5YjLzpjwwm6Er
 ZHjUrjlzTr+p8qtJeppZrXihzn8j8+Zo4KVPYiSJ0Ia3WZMb5TXgraXMlqvvk/OAU/
 xbNTFdLyV9p6EIobQSY5hdxes9e5HkiwokBE4h3+K2gnnfL8GidSgYECvj51y9oCU6
 p2CuOycOVrS0bTihG2dALWIeuunfJO0+PxnDJKEGKodBoPqm2+LEsNu+kkHTyC51OG
 TMPGztJ8GwIF0le6OJxKnXwCqr92vjxW8oBDYoVMy1SZ7Qmk2mlOVbpT64DCHKftzU
 jjPsi/q4iB+8g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] spl: fit: reject failures loading an explicitly
 requested FDT
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-1-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <20261104-ccaione-upstream-spl-fastboot-boot-v2-1-cf9781441ed5@baylibre.com>
Date: Fri, 06 Nov 2026 15:15:31 +0100
Message-Id: <179397453138.1035345.8797703947128467131.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=645;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=NvCSY2rw0dESdh5nFTYgFxIGtHjIno9olPXTpbxGUE0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7eEIGt/3l8TK1RI0GYQHqrh2vWAZ/GwNHH5vc
 YsQ1NTxQ5KJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3hCAAKCRAZDR20Zk4Z
 NZfOCACp1uPcbHxbnl2UWJAwlm20NtuXIiXnzSD2zRnzOG2/iyRdDaWz6BER8rngaQXLyYgl8OZ
 vA2EoiXNPXUsXMhP6LU4+5i0k7NgnVC9ozrH9ugzzNWi5fLGa1qsf6o9tu11MSDQdeD4X376WNr
 tXvhZQGMFEFRh3Dg+r1WzbnH3bwzCSPtHSDxAC2J48ROUoFSRA4f5FKlcT9/iSUG9glnZNCrE2J
 uG5bbD300aHVwbeqoxHPWwuA7R+5UoqI6tA6gRpU4XW1OCi57fJvdRh049tX9y0EVAcdrx3LyQ/
 WRaIa7Rvk4uGF+T7xnY9wAZiBcvJnSiT7Qq0IoaZk4tOg/5W
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 10:40:21 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> A U-Boot image may embed its device tree, but a FIT which explicitly
> names an FDT must not boot after that FDT fails to load or verify.
> External FDT data is copied to its load address before verification,
> so ignoring the error can leave an unverified device tree for U-Boot.
> 
> Keep support for U-Boot images without a separate FDT, but reject
> failures for an explicitly requested FDT in both firmware and loadables.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
