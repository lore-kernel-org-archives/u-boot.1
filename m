Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC1C79FBD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75CD881137;
	Wed,  9 Sep 2026 20:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57nZVY6b6rQj; Wed,  9 Sep 2026 20:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADFFC8113C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788986700;
	b=YtoAECz7EHG/wo1cK4ziYOij3EkdwKaZCQhUEc2wn79Iv0iLhnzBu3Vm83bfTclg2Dk0
	 CfbniuLLVdYQlO1lzrBWMxo31G0UXjfPNpK6+nO+DljHlVHOSTxyt7BLuqKIFncbrZ4hM
	 tkfJgib4PIJdSb3oGb/GZswqY2c85fkajklDrk9Eyms+s63LsoKwY4RqeCZU6R6eNB11z
	 lwwwtXQ/xa3hMGv2fGKTh07LQDtAeEyiM+RQCvSukOF7OMmYbBs4stpD5VzkyCorULQJi
	 h/q3lpm805eHCKs3lnznadaKvoFTz2dVLDEOmQQNTNNg/cUymWixHLzMeBSQDwKpDjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788986700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C1iYwUJJ6KwasFsc+IL7myuNTL7B4tSaDih8mAIZ/yo=;
	b=C2VGHNTl/nh4vQI21YIgKkHTM4N6c0Zvkd9MaoP/IPC8V35Jk/vdKeKJh6iIKCw+Nc0z
	 oNjKHMspug8Mo8urt0CHJrBjpRFwM4sA8jLbxWPl33m5FQQeYI+GYFtZliCdRO35zkRRU
	 prnAvhwFB7vxg/7DbswPJXuiX6W3GwpDcmL17/TKIw5Xr9tGLCpQHhSXYS5bqoEilc+Cl
	 S+kJ6dtsudfHzXfuRued75LT5Bwi1kNzcUhCnKaPKzMhMXMPCE3+poP/Elh6vcgC9sKDb
	 S1rVfbSLeO/uVA4oc1CSk4tdCNIsXsSU7hdyUuFTjbF6pa2CekEYcMZzC43N9tuY67w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788986700;
	bh=C1iYwUJJ6KwasFsc+IL7myuNTL7B4tSaDih8mAIZ/yo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fY3akrzWL8nP/pTbyTc5hTtYjOuHPdswos6/dlcvyPOPu8o95WywdVgU3Gmmn2mps
	 PLzJm9mgQdzCuUPnSsDBTC/WyA/UTBuDQF/UbQ0c7rMNbFLqhugQSFnyeYURje3sMX
	 khc93h8P8aTsvuMBJt6df8XJhJVCrDQ5H2JfSGXTv+eZJtr07BjrgXHhGqhVnmOWBY
	 9jPWGiIfh5m8XXbraizHewnJNbWbRGia2st68GUS9WlHhONNkCoxgEDWEXM20AzsXS
	 DsO2pZP46KnIc7iSoknllXPb8UjpP3xoflC5X3LCkHciGlVQz4Vt1CuhOFAa91XsU/
	 wQr7WpGp6SuYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADFFC8113C;
	Wed,  9 Sep 2026 20:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C7433AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1D7840244
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqVzYFK3cYFk for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 19:20:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6460040098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788981651;
 b=FST9MCiWjFAcZ1moSewcSg9+EAE4d5pQ5dC/P93hc7aTDb1EW7d24FCVD/gFPtgmyPiq
 2R27/GS4zyLzRCt2m8MAKmbDS5Qh9ELcducI1YZWPE9q4HzFgexvCGU8yrgEeHhhxLCbF
 pHfwgXBfMCmPKPerqndFUs5qvWWYBVQcOjwV+/89hP8ioLKXAZJURZHlNZTKjnd8iyrBd
 TwPXOjre/OlRYPitHZkOd9hKXR7/ZIwj6sAEPg41abwGYSCxQ0x42RA6z0Ez8hNX1EZG2
 dtJMpGevfPnAs1YPMXx12/35TRgoT5nixiLgzRd34TnEIO1hSw4vKP9VvLQbByZQVXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788981651;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Spam-Status:X-Spam-Checker-Version;
 bh=C1iYwUJJ6KwasFsc+IL7myuNTL7B4tSaDih8mAIZ/yo=;
 b=oaaoGX5nYjQlOweLJFUGWEfTJ26YK/N+IhFzYG243EzO6MPXs2o4MM01hXBkNHGedaZo
 85uvWtA/wgYE9zQzkdoiLSP6L0DUl5Cwsb3sICZ/i6CDL2sIDNJqe0vdKXC3Jt4lan5/U
 fgSjfPY+I/6bX8MDhgLe0qJzU62Gf69TK8+53qXEKTFUwCO8mgT7IY+gToxKJOJYVYxHk
 n4pQqJk/FA553qKrELqOcay/do3HOvvE04bvGJbNN2GY/kQP8Kbeudq9umIbbKvEq82+g
 tByNDrEVmwofANk7L8UO8NbpeUvW8WdUK0p+x/ymXl/MTm2qv6X+gxHXiCSxBccGQfg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=XZINJM42; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=XZINJM42
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6460040098
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 19:20:51 +0000 (UTC)
Received: from srirambuild.corp.microsoft.com (unknown [167.220.26.49])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5D57A20B716A;
 Wed,  9 Sep 2026 12:20:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D57A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788981609;
 bh=C1iYwUJJ6KwasFsc+IL7myuNTL7B4tSaDih8mAIZ/yo=;
 h=From:To:Cc:Subject:Date:From;
 b=XZINJM42RxKlHOkaKhFM2ShML61azYwfS+tDDww1Vqzm0KWoEHWUvKthfXh1/tXHZ
 q0Ca08GNQgVp61Snnjnib6BnPSzcm3AsV8AYnY7N7VyGjPn+frI3v+mjOGzYDJA9Ae
 VJ6ikCRVJ+ale0QCdrYyK733HqyZ3uQk/ICK/NkM=
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>
Subject: [PATCH 0/2] board: xilinx: Fix board name overflow and allow board
 ft_board_setup()
Date: Wed,  9 Sep 2026 12:20:45 -0700
Message-ID: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 20:44:50 +0000
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

Two independent fixes to the xilinx vendor common board file, both found
while bringing a downstream Versal NET board up to date with mainline.

Patch 1 fixes a heap buffer overflow in board_name_decode(). The name is
built with strcat() into a 50 byte allocation, and the length check that
is supposed to catch the overflow only runs after the writes. Each EEPROM
descriptor can contribute up to 29 characters, so a base board plus a
carrier card already overruns the buffer with EEPROM-supplied data.

Patch 2 marks ft_board_setup() __weak so that a board using the xilinx
vendor common library can supply its own device tree fixups, the same way
the file already allows board_name_decode(), board_detection(),
soc_detection() and board_rng_seed() to be overridden. Today such a board
fails to link with "multiple definition of ft_board_setup".

Both patches were build tested on xilinx_zynqmp_kria_defconfig, which
enables CONFIG_DTB_RESELECT and CONFIG_OF_BOARD_SETUP and so compiles
both of the changed functions.

Drew Kluemke (1):
  board: xilinx: Use strlcat() in board_name_decode()

Sriram Sriram (1):
  board: xilinx: Make ft_board_setup() weak

 board/xilinx/common/board.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.49.0

