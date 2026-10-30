Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD64606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rpW5JeMr;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=AIagk15a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A1E581335;
	Fri, 30 Oct 2026 17:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lCEeB9c2sqDy; Fri, 30 Oct 2026 17:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 881EE8128A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793381043;
	b=pN43tF+iDZ0ghzVPku9XRq3L/s5NrA4f0N6Hmcc4eIXxvR+HsNySWdeOw1z4Yc8w81dq
	 5Pj7BGP+kZICNJYdfoZwNY7joKg5dmcaNLYElg7r+00MAjzBcZ8W+YYqUaOtv89G3LTBa
	 jDFPOjnnKGSAdQWNK+Cm3gZIjRJyvVZorL2cvxmkgQoQr1B2/4L8w6UE9gZ0lLeWDPwG4
	 YSBQuvNUR2vZ1a11GITfGSHPIM3sgqH/lQQAdIw6rBoppQGv+9YSy8k1ZcAkCDS2utOpX
	 R+0ZokWmTmRcZhUxTi9m6AjV4yaLhg48X3SgPejdWMq1eXqmcRIqXcJq/W7gjn22oGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793381043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RkCfLPNQFdHWbXDIZPC227NgkUNgAexLx8OSwvs9IfI=;
	b=F7SkhLWMLdFfKn3+sde8jwmylCl89geYpaNj7c5PyZVwPl5CmJB1sf81ZAx3OI/X6zen
	 phFyNpCnutdngltsSyghUYOC/utly3Ib4xIjn45FWSt2rKgJEcD8vGvga9f8ZAOmXpY3v
	 UwXeNN+do51N6DGmDgXs0q+jC/7rjPnxQU6WH0ALNGtHcMIvGT7Nos1PO1yZ95tQ/2K1Y
	 Wx/fHYv8tXUK3eTB9qVu0BrGjt+WYVmaHJ+1YSdf0w/dfNikUXyCJBc0GrNVImLx4k8AS
	 9rZemFWOjcgI1iJE/p7ts/r6+4KPL2QjNPxk0TcF3pHy4C71vbZi6VZ3aBmXotaGYUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793381043;
	bh=RkCfLPNQFdHWbXDIZPC227NgkUNgAexLx8OSwvs9IfI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rpW5JeMrmYyKJ1iUZPrWL2vYA/5XEBG/AJYY03LfFtaPsD3ybSfBKpvsVo7bPuIca
	 V+6mNeDw/eA7C6mD5P5WiA9IdUkM+8VS5TjxEI+UjdVaj17Hzj3aJWBtyG5PpaVhFh
	 A+bsvptZLLfzsGjK8x6cBKVBOBQ6bD/fWoxwRjzo3nqAO8s0ehLYtkZLAVncnvy6do
	 dNmOQi8dL3DwwduuOrtss+pi2jvtJUqKaLWKTw+Aq8ZS1Qgj4fKxmiZlbinK27CeUK
	 4zUVEWJvm/YLhITldl0uQLTOqtiLU/BgVqAMfaxVGQhjjKOuvUVx2lFRrhT9IlAQJ/
	 d/y+oqi9ZvZrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 881EE8128A;
	Fri, 30 Oct 2026 17:24:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D089A362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C196860AD5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dnsxE_SFjOs for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:24:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 80F07607B4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793381040;
 b=YVSCKB/wFfNeQXcS0mls9STgTS45ydUrAcuOoew+aE8/bUyZ+DohWLu+Lz0HiihQbi/x
 5sAFn92Bp0AZgcaHv1NvXpK7unjSdZXV0am6UIvUAlVLXhnqq1JW3+mCecrSOMFFYV8nd
 oMlYreDd4yqz/xFVBswssoC/BJyXQqEG4V8Es/uIeGwkO2VLzS7ayb6pdr2VJjZcdnMUS
 DOfzyWxXmxYgSRfJgqfCzN5QqEenGctsSevTMhjKwC2QuKHMUzcKUVQx2r/PLWpchrOte
 A8OXfT8NeGplIhSjjGNWDrckEffp+JFvBe5fUTd3dkoAK6zEN/Yird1eOabJZ9KLogA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793381040;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=RkCfLPNQFdHWbXDIZPC227NgkUNgAexLx8OSwvs9IfI=;
 b=J1Y5r8MT5ImJxZGjGEQOEbzxbqdLqB0QgS1elkYWqwfJwudqpO2oOfZG61JJlPiwJkhB
 Indqs+ScKDNnoCC2qaRptH5wNNFPXWp4ppIND8fiV31oaZyLjEFqJX6pU9bbX1t4ZhKN7
 wwGM/v38hbSqonibU27FGgYWm7diwPAumbHP6emWvLp/ZNRySuSyjNSkOZ0A7gLUYcyHL
 vFM429VVK4iaJE3939exZGoe8ufY5hlVlPUjv1pYI2H4X4XAhsQA2Lfzm8m9BmdhB0BlJ
 5biRvnIpVNl5uNY/gBB/h8OFws3n9TGB0CL7c9qvxxM68e6HlBQhTkjx1I24MmnD/WA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=AIagk15a; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=AIagk15a
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80F07607B4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:23:59 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGScr6mgDz9Cc
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793381036;
 bh=RkCfLPNQFdHWbXDIZPC227NgkUNgAexLx8OSwvs9IfI=;
 h=From:To:Cc:Subject:Date:From;
 b=AIagk15a4c5rgTqys9+oGylA4U3Lhpi7j+eFeTD3M0/zZzxQEEH7gnnB+Gg8kxUu5
 y4zARSXKG7QdDmsmcPIwzw0a3egjF5znOmcnlGZUoYDbfdDl2oUMmaG2lMZUA5YrwC
 DLBaezb6XaQ0w/zbscfeEWT+eJS++GugXF9x6sN+oVNEgyqAOKifjlKC1O8lxnQPG6
 qsXrCZePUgH3AOlI6CfefX3ug+IPFgUA3GgaeuufOkGr/Ss8ONZBAF+RHj2n3u35Hk
 3MlCwuiVsM4ljkxutrzruO5Re9rWVLGZzooYaIWVuy4DhSAY1SPyMx4C1Tpos8AOhu
 9e2u64IJtbLag==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGScr31MKzh1L; Fri, 30 Oct 2026 18:23:56 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2027.01-20261030 into main
Date: Fri, 30 Oct 2026 18:20:03 +0100
Message-ID: <20261030172337.791283-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

This is the late pull request for Rockchip as agreed two weeks ago, as I was
off for two weeks during the merge window. I'll be back to the normal workflow
for the next pull requests.

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1801

The following changes since commit c267fa81d42b5a5bd1055d3858f74496faa6082f:

  Merge tag 'ubi-updates-for-2027.01-rc2' of https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-ubi (2026-10-27 07:38:42 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2027.01-20261030

for you to fetch changes up to 32570931295195c700bd52f0b252af46107e65a2:

  board: rockchip: Add support for Graperain G3568 v2 (2026-10-29 10:58:21 +0100)

----------------------------------------------------------------
- Increase max usable SRAM size for PX30/RK3326 and RK3328,
- Add support for LDO9 on RK818,
- Ungate RK356x PCIe clocks only when PCI support is enabled,
- Probe RK35xx clock drivers after bind in SPL so clocks are init
  regardless of probed boot devices,
- Add new devices:
  - Graperain G3568 v2
  - Xunlong Orange Pi 5 Pro

----------------------------------------------------------------
Coia Prant (1):
      board: rockchip: Add support for Graperain G3568 v2

Dennis Gilmore (1):
      board: rockchip: Add Xunlong Orange Pi 5 Pro

Jonas Karlman (7):
      rockchip: mkimage: Update init code size limit for PX30/RK3326
      clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks when PCI is enabled
      clk: rockchip: rk3568: Always initialize clocks in SPL
      clk: rockchip: rk3588: Always initialize clocks in SPL
      clk: rockchip: rk3576: Always initialize clocks in SPL
      clk: rockchip: rk3528: Always initialize clocks in SPL
      rockchip: mkimage: Update init code size limit for RK3328

Shigeaki Asai (1):
      power: regulator: rk8xx: add RK818 LDO9 support

 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi | 25 ++++++++
 board/rockchip/evb_rk3568/MAINTAINERS           |  5 ++
 board/rockchip/evb_rk3588/MAINTAINERS           |  7 +++
 configs/graperain-g3568-v2-rk3568_defconfig     | 76 +++++++++++++++++++++++++
 configs/orangepi-5-pro-rk3588s_defconfig        | 75 ++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                 |  2 +
 drivers/clk/rockchip/clk_rk3528.c               |  4 ++
 drivers/clk/rockchip/clk_rk3568.c               | 19 +++++--
 drivers/clk/rockchip/clk_rk3576.c               |  4 ++
 drivers/clk/rockchip/clk_rk3588.c               | 14 +++++
 drivers/power/regulator/rk8xx.c                 | 45 +++++++++++----
 tools/rkcommon.c                                |  4 +-
 12 files changed, 264 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/graperain-g3568-v2-rk3568_defconfig
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
