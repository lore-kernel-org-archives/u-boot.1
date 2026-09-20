Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF21C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 16:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 591D240BA5;
	Sun, 20 Sep 2026 16:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 32XPQvWn8ecQ; Sun, 20 Sep 2026 16:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8307C40A24
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789921179;
	b=DA0q/JyAe7Az+k2gl/Uhpq0w86ZYDT6RcpBqx6T9ZO0N93nDhswv231avgXNmxJADdSv
	 XArzKg27vczzQrGDN2BICKefbwGgz5MCTgZIY4iyz2BAvhNlz2mVPfLmsP3Baq1xsyZ1T
	 j9Vkukn9T5PPC5HgGYNJ+v3LIRN4exZfHZrPNRXHO1opqDc0h31AIT0IBL+KrUTMF6qgp
	 HdGdsbv0wyTaqNFx60Pd5vFx6XVU2fy+mcwz585w5ononxBRvP3+vcAJC84wAT9AUehQl
	 3QnKwykTg3lEgAMFSM7HRbswdZR6pMv+cv54JpB59NlfqNDHej8KuJWZnvXCv0pWgnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789921179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PQwDrk9TTROlK0crzO9Yse/1qJfXcU7HDXVdpKhuLJI=;
	b=BZqKu1QXzuutozj7Gl2+JRXf0jJaXE5XdsNP1HJnhndJpwQB2CBm1N8Hi7ZdryVqESMv
	 uwY5NjVNaMIL7VL5nniTWrI0E5sfJihBqt1/bqSVYTsH6MjeUoahM+IvFk2vo730ArlGd
	 02xu3ffi18Y170XBeyJSLBxw0pktxkQx9zkCk9+qzCFTWveT9o/gl9BKfB2UzqZYPQj+o
	 Wiye1pVC99F/ZcvhDMMDEg8b/yM/KBZ0pE6u5D6hdwUEdcJUwv00SXd/seqMxMqmMHe2Z
	 3KhfWk3G7LMS7ZFRCzwzQ0n+rcSGhPfmv+vR6j4PABrYGmymb0jT8hVfPuqu2vRzwWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789921179;
	bh=PQwDrk9TTROlK0crzO9Yse/1qJfXcU7HDXVdpKhuLJI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HpTrNmpZuxOCOYPXrDfYlGYfub1I5B/Nz9w5RW9p74RfNYCWudbWcGDUIavZ5U6y6
	 KluwuW6TuVCcNu5yyrb3CMr86TRmas8PllV5wa3j0sNrhv8eG94MUT5+NX55g5n0Pa
	 wndwBiPoEbHJFVkydGN3cTPEyaw6aS7r/k+P02JmdJf3thFequzD14ze7gZOCEXclJ
	 KUjig6xmn+t9wabjRVsp/unHIPaagcPe97oB3sgmPKJTrCE+bp05Wyv85sSr8drgqq
	 B64m45F7ZrPk4U5517M1zi+pqNRfrsxE/COUflqDUYz08eyIfGaTl2SZVwqv385al9
	 IK+EM307BkD4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8307C40A24;
	Sun, 20 Sep 2026 16:19:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D64D3FA
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 16:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F2E8606FA
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 16:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvqldpOYrlwU for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 16:19:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B06C4606F8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789921177;
 b=tbtb/JTFBiFedpN5RaSo30dBHY0oQrM2S4BMUAB1vWhQ6xJWFXoh3p9o8shhLsTRUotB
 J8RqlT/nbbFNIxl/IcWTLmDyoktDrF6OIJZeBy0FDSqzaySVag/WPRlipMCfb3zbmm3xn
 Fmwgai4Dj41pfny/7QL5hYN+5J1DLmcbLTWCziGBlMBWebtxvJFhJBjoqiIG1L3kpCHa0
 5XxpehdxyY8aOYIu+17arFDCxCAXmK+5YBwx0r9lZjx2Y4AHGX/TCxP90S/2BVqhakFeN
 dS7kUcUKXWcQl+XitDstpkS6rPVWO4+sZmDuS7WssLB3kUOAydpBINU05N4OMzg4lXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789921177;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=PQwDrk9TTROlK0crzO9Yse/1qJfXcU7HDXVdpKhuLJI=;
 b=OD6z8DH8AzKEwJx/+9RQ/Q88LyD9XB8yhCOCs3WO4Ac754OboRmyHRd/r7trJ1zKAG3I
 E339ni8xlIBIitVgqirLdjfw1vScQxqUpWfXZaoyatAgwKvS9jYaNpeKcoOs/2ZcBcfC/
 MXq+uZiuw4MxNpbAliA9T6kzu6kr8KqGl/1ZOkoKqKC9tRRnvZxfFbhYNWsEOzyMWRBfQ
 1HkfCCeeWzxyIgkM/e9L8lCCuM4v+mcnHjBszMZnUTko3mHN1Mitri5skcDKYEFUsTSJb
 9+n32g7KypA5MO/1Lb1vVuuzfu5Fn5JlO+6lOzr1o8Bgp9SJieXPeHul8/7bQI1dtaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ScgfZgMH; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b560=hn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ScgfZgMH
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B06C4606F8
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1789921176;
 bh=PQwDrk9TTROlK0crzO9Yse/1qJfXcU7HDXVdpKhuLJI=;
 b=ScgfZgMHNKte5teFkAi/bc10doLBc78xPnHmkgakWAJRJ5fvh4Im3ceX1pgcAZx5+jI1VFYP2
 ijTaZH9zwwdJpkCRlLSG7NGHhydeJXM0LkupcYCVjKG6XD6hGfV+4Ye47Av/yRJrtMN7Ouugexs
 DXYnGD3/4+VLFvaHJIxOHhCbP5ehZlC6QIiLMkfd/HC4DidAMmI7skh37LpCudcfk78ioZsqdo5
 qDUQSqlOMu8jbRjdA5QYcFTWRzdZCnS9MwHBQiSMeyYd8v/t0WTNoHD+p/DqPbNCRXmWyW8vggL
 fQgaKv244rQEBDkmI8gNl5wG/DJtFNKIB/pzK0oQVYsA==
X-Forward-Email-ID: 6ab007977511f8a853d43694
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.15.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
Date: Sun, 20 Sep 2026 16:19:29 +0000
Message-ID: <20260920161930.1880133-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
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

The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.

SRAM addressing only seems to use 14 bits, meaning that reading from
0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.

Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
reserved region for its global data, malloc area and runtime stack.

TPL on PX30/RK3326 does not have any use for the malloc area, the
generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.

Current memory layout possibly looks something like:

  [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
    [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
      [..., 0xff0e08c0)                       stack area
        [0xff0e08c0]                           stack pointer
      [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
      [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
    [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
      [0xff0e1000, 0xff0e3800)      10 KiB    code
      [0xff0e3800, 0xff0e3848)      72 bytes  BSS

TPL currently does not touch the malloc area, instead the reserved
TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
the TPL stack addresses deeper into the BootROM reserved area.

Using current offsets for global data and stack does not seem to cause
any known issue for BootROM after TPL returns to BootROM to load SPL
into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
could theoretically change this and cause issues for BootROM.

Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
to 0x200 to avoid overflowing global data, malloc area and stack into
the BootROM reserved region.

With these changes the memory layout looks something like:

  [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
    [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
    [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
      [0xff0e1000, 0xff0e3800)      10 KiB    code
      [0xff0e3800, 0xff0e3848)      72 bytes  BSS
      [0xff0e3848, 0xff0e3cd0)    1160 bytes  stack area
        [0xff0e3cd0]                           stack pointer
      [0xff0e3cd0, 0xff0e3e00)     304 bytes  global data
      [0xff0e3e00, 0xff0e4000)     512 bytes  malloc area (unused)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
initial 4 KiB with the 16-20 KiB and the data matched 1:1.

Changes in v3:
- Drop TPL_MAX_SIZE change
- Keep a small 512 byte malloc area
- Update commit message to reflect changes

Changes in v2:
- Mention BSS in commit message
- Update spelling in commit message
- Collect r-b tag
---
 arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index adba1b49a52b..0088d436d36f 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -81,10 +81,10 @@ config TPL_TEXT_BASE
 	default 0xff0e1000
 
 config TPL_STACK
-	default 0xff0e4fff
+	default 0xff0e4000
 
 config TPL_SYS_MALLOC_F_LEN
-	default 0x600
+	default 0x200
 
 config DEBUG_UART_CHANNEL
 	int "Mux channel to use for debug UART2/UART3"
-- 
2.55.0

