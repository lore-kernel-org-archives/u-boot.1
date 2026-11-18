Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3A606A335
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DafpNPHp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc7dWlSG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D6A460A67;
	Wed, 18 Nov 2026 15:43:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxqBkwph6QRm; Wed, 18 Nov 2026 15:43:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60A6360A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016628;
	b=ammy9ts9e9l0lHNiqrXLbJCs5isDmvAJIhiE4DQSFbMOSUoVPAVGtr35901zl3TKSEbZ
	 Ztfl9YFgIxWe4uQ+J5Y5ezQZMOQfAPxzsJ39OzbnjHw1yFqmp4ManMxf0LIggf5z4eZKf
	 rdb3tjld8WEqhqhNyAECnBL5+X9M6IVhGowDc0lPGksCIz08+H2iZ1W1wAHSK60RRzxYN
	 BSoXYdOIYRN98GTu5xdQ4aN1ViFm6+/eK5+JNizm/xibfwsyyg4e8V0rBdUCzlqH0MDZg
	 7XidYyP6IMElqRXIpuPqyQiexWf/XYmR0hSV+L0Z7s113va+9AyswmEER2fYxwmGsBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3+6+Mv+H/wuuZQaX8PMd8OMbPV9YN9yyfORR0x3ZeQI=;
	b=q9Djf//B2IpDfqIOBSv2AmwpWk5NGOezkZpaxrdaARbXhvzA9rsjdHO1y+o0EZOKz+NZ
	 w3UvtnrqsDml4i3TXldG6a0m8Jr/3omKhOclA3kzL97aIBgtazPZC5t1DqVFHhreIMBF6
	 bCZ/MQVZ5kj/x+xWu1CZwTGMpzntPT8CBien6NWvaHsfNq6epFUoJiENhGovdv+w2mWpi
	 x7+HoD2/0XV/4LeUMRckGK05RQTKRO8aRnx4sa4nBrn9jjwEgiPg3o357pb7v0qZmWTYl
	 w7Bl+gMjRbFhyAoYXJw4wP5HDsVh+MHHFS78whRPKg+XusBqMAU6cpMN2m8RpfNZwKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc7dWlSG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016628;
	bh=3+6+Mv+H/wuuZQaX8PMd8OMbPV9YN9yyfORR0x3ZeQI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DafpNPHpu0k7N2nz+NepumJqpvg0KTCtqW8+XAD9t6iGrVakHwzIhsi5I7j2DyO9o
	 m0ANecg2VFIn8mKlwjxdh1+NbbyCGgyYE+oJNZzoHxh1gFl0yRF5gcNcur3FfgVL12
	 csBQiRUTuHBvt2spk69EuSPahX7JhSZq49G+AydbGjFvr4VRfscIs6lN1GgdO3fk6r
	 qnlC4GNHOOSPEjjRbIptV5uGZMDlCE4ev1FLr9B6VeVlcuGm3jD2RFbZ43tHDZfXX1
	 khfQZbwOBGaz+2dUdudWN7Dbi7AfMP2rBQdD8Z4iKQjITkMoq+Miit0ltdr4QTKouZ
	 LkA6DObq/64bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60A6360A51;
	Wed, 18 Nov 2026 15:43:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E14B3977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3D7D60A67
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2yXrnMwtNWQ for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC2C060A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Fc7dWlSG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC2C060A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39948624D5;
 Wed, 18 Nov 2026 15:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C381F000C4;
 Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016622;
 bh=3+6+Mv+H/wuuZQaX8PMd8OMbPV9YN9yyfORR0x3ZeQI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Fc7dWlSGm4JGHU4NshhJl9GhVCOEkFy4SB6D6Ib3xow/m1IhGvPmS9zGHLSA4pS1s
 k5Zr9iUIzg8zCNuK5e6ZW/qMdHiz1Y0j8fhLGBXaD144947+f8zku5GzH4ukGeWAPp
 0FsPjRyGwtJUsnnEqjc5u11PdGEiAnlByPc/cbyuSzbY1uy2G4N/w+ZENybriOyFyM
 eBDNVr5oDA2HLSIXqYPoYc/biRYBX+dL2jzKwxTlGBbQy+6VZepjfpxkB89F02kOYJ
 I5hX6kwRcg/zZSMsRDeQS73kO2ecoj5NNhFEwkgDku4Ut7rDL6dFu/lfvsBKljkFa9
 /VOY3+/OGVJwQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/5] test: avb: test the lock and unlock commands
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-3-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-3-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:43:33 +0100
Message-Id: <179501661322.306911.9380270626438357890.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=597;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=FCDGkWOc5Ys+gXig+Apm+4nLTSfvErGCuf3cpK4rbpQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/cenUJrvVueNLGDJwiZ+vb+uMbiAyn4x8cjct
 k5WP55FtFiJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav3HpwAKCRAZDR20Zk4Z
 NWpSB/9DDVFSAJ1mLHP+ln7TFM0L1HLArBvTU6bXe+24XWg/cyQjcNz0KQt/UWlMSNTewwUZdyt
 IZ7U5zbyNnUPPeTVZ8lN/1WYNLKb9JbENkRZjOzRyE7o4f0BId7tQb+C1Wsu+aQyQ8W7o6el2KZ
 YKfziS7GeD4aUbfxybHzp+V/CDjuWcTuN14hgrxJ9SNtWnt73KEGhG7wl5skNsyXcpNeoTHGyFF
 LuifwanUVBISf2hsvLRpGdHtG7XQdFv/zCgZJHRi87IgbdE83rsqrYctG60OyHX7a6OEgwDHHTg
 hHCRj7VjNUYq/XPfPw0S+iPZ03Z5FKYTjAv2WKKdDbPKkCdO
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

On Sat, 07 Nov 2026 13:52:51 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The lock state decides whether the Android bootmeth boots images that
> fail verification, and AVB requires the stored rollback indexes to be
> cleared whenever it changes [1]. Test both, and that locking a locked
> device keeps the indexes.
> 
> [1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#locked-and-unlocked-mode
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
