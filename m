Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B96CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A303E8136E;
	Sat, 10 Oct 2026 13:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LSYj38Ce_PnI; Sat, 10 Oct 2026 13:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBF5C81299
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638098;
	b=IjdZ27xfN6eL1xmZTh6wgJdCwDyF2v/fA7bkH839zJdzry4QYst8m739hIDmgKwAZRx4
	 GrKmEl+jEENc8uF37rZ0eAJCmQcftv7l4r7Ew+6KrWxLlIMezwmhkASBn2g6NJqN7qy+R
	 JWQecAXciDCvfNLjPCqgZNWrLMJK9bF7eJoBXC9fkDEPBXwIbriosIBbXrWUxsXXpy78A
	 EP5jm+YgmB4YGn74CveEAaGa5Am+Y+gm2CEWTGSqxqL78j51z45KrlByVGdfhCg2/Tau7
	 38Skzzot/Sb0TcFStXjZtI40lJmOpQ6tM5f0vV37buEyJ3uOygw8meewZMMdz/gvY/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
	b=MBuYegeBKtE5h+2hYa1eQfrjMG7vu5hHD57KKco6fuYwlEk8eBGMZKTtaEWafPpQMFFq
	 p70orxQuijN9oEEJZ/AKi90diISQKmYX7Wh1al2rWrGCY38cB4SBmvLoykB/rSMmbSoZF
	 LJgLcGBcEkR/STSZoKmArZ8sJqYWHQ5j5OS7ZX6Cp5prXhiY6lC7ZYnYi326p/XgmnbXs
	 chTPhE4ixhMOQjJnBMgrQsGnkioSQn6Fr27Xl7F5zPF1fR9OjXjBVJTBAE+I9hf07ov38
	 c8xQltSOsWp/LsxpwlRxjA7sdNHFMwgRbczpf/NqLj9jxZ6VYW5l3+zGvIx0sMnyrug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XBwfodlN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638098;
	bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zrPbACx7HwU/38l5MQ+fcAfrklE8LApMlbC+MnJrvc2/MGxfzhI+978aVPIopX9vs
	 yzz+10pxYJoOXnsfvWbh+sWVXIhIoxXeKMiPJGnwT7qnG/vKImMzbrpVX7qMa+rfYQ
	 82O9BLIu3V2vLI7nwaiIaxciBZybsjfRIH8rQlZ1d9SlDFux16+CFqvh3jfrsP6ncj
	 AkNNu+7rVVbfldQkEyZdL/e/K9rPkPhOsW03jrwDP4X3RyaCBb6CQGOgcun3TS3amU
	 0qdqjMU4sGwmIhxCJcOLWnzLMzn1K8qU2ml1Jv/tcmiAbg3d9vpRInfA1pECUIaPGW
	 aX9YpV6EGb5ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBF5C81299;
	Sat, 10 Oct 2026 13:14:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DFC822B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 247C481155
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s9FWJGEw8pGd for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6865E81061
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791635301;
 b=ni3fwIjXZjBvnYuJezO11SUYtxSMAYLyWUCd1ynbvDMxQAKXqfE4XcWhpNMMPpetMRQD
 wo7TSEfNV9ZqBdYciK2JC/DbA8cB0diMGqCHADuwrzVYar++O5tvyEtmI50eT50y6VZMT
 M+tHV3ggwb7WR6neqJshFRHFTzcSjx1Gp4PNrJ+Nvv9WXEWBGiheF1Z4IzF6wrKwDE5M5
 13yw4izuR6IAG/14SCvYyfJkclwJ5671zEYdW9JHUFeSub1wKEHCgPff7Xe/amtHW6sS1
 vGXpt2LpTA3EOKTT9CoJRyNvpxAZfdmlOL5RqM+Xo078iuGkoLBTeMWpteWCsX7Dg7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791635301;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=j4XGP4xl2SWBh8r0lXbsf/zSNJw1lx8/F45ZE5IqlTo=;
 b=oeRS5oG4/6mrfpmyzUralRUaQRJNe4YSW4CYGakRajOrX0hNgWEv4iIYTkEJ02usijkX
 BeQJhOCkylsNUFJ/1N0rpDrVc4pCS4/UQPTrO/48NYCpHkhabn4o18ZwtqD1iKGL5LJdp
 AWywKk6Jaji21rbuRPxvYPut3ai5fMSLsJqseGzIqfy5No7HDXptAQlWo+Egomphg/ELi
 KQdHjC3r+bA2ul5fNi2tvF17rCa3JHFx6Vysq3VHUsbi+lj6JistKlt3NOI1IlkLKzjiF
 9SJwLQp3zAeePrpnKJg/iChgm1CaXskOThtzeXHpDI5Q34pTPIj/vWJTUiawFCK41NA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XBwfodlN; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XBwfodlN
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6865E81061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7718543C81;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 501EBC2BCFC;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791635300;
 bh=rcLjF6TEpSDJjnEo+5tIqtcWIZ7l/BHEPyV3oLz4DUk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=XBwfodlNvELpwm6X3JZTfoTsETmZosjdxioRF7dC2SgCCdQVaDV3VsXi6JYnX7Hpk
 lOUCCJOlz66rDHzJ+CdeybyLvZQ6hQqUEEfi4UTuiIRw6xkAF9Wq9VpWfNr88BQSsI
 /J6vA6Ps0NySymzY0clXLkvLZKTOjUfX746WEkHcyOPpzfDggCwvQECfms0cqTUazF
 QBldziRP4nOS6sKzpNPEJoFJB/0L+ZO3au54Vhro2Lxz8t31pDrk3d+ZLyTfSjqGlw
 byGr4tF1SmACnSmdcj2XagB65EYWg/N1QTKdIFcWT3wszZjZXHf9V6VwpWoogcUc8Y
 ohmv6U2zfMH4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 36C74CA9EC5;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 14:27:53 +0200
Subject: [PATCH v2 2/3] doc: button: document monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-button-live-monitor-v2-2-004f47a4a7b1@protonmail.com>
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791635298; l=1710;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=V1QHc3j+E+u6j39lWYuquKXtDVoLT3DspVc7Br8oKdQ=;
 b=el7dK8xFlZBrZucJ96yK0qIkvmxaiEEJkKUB8dGoqMr8BBO6jMTO5kQUuiSaNWIypi975G86K
 Byj5Vd3jAcXBRXn22A9qS+95x0/q5TC8Uz6X/pF6fJjJCeXrEwcnSiT
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 13:14:42 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add the monitor subcommand to the synopsis, description and return
value table of the button command page.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 doc/usage/cmd/button.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
index 6c6794f31b8..49bc373b5d3 100644
--- a/doc/usage/cmd/button.rst
+++ b/doc/usage/cmd/button.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     button list
+    button monitor [timeout_ms]
     button <name>
 
 Description
@@ -43,6 +44,19 @@ A list of all available buttons and their status can be displayed using
 If a button device has not been probed yet, its status will be shown as
 *<inactive>* in the list.
 
+To watch the buttons live, for example to verify wiring on a device, use
+
+::
+
+    button monitor [timeout_ms]
+
+This probes all buttons, clears the screen and shows a table of their status
+in the same format as *button list* (*on*, *off*, *<inactive>* if probing failed,
+or an error code), refreshed every 100ms together with the remaining time. The
+command exits when *timeout_ms* milliseconds have elapsed or when Ctrl-C is
+pressed. The default is 5000ms. A *timeout_ms* of 0 means to run until Ctrl-C
+is pressed.
+
 Configuration
 -------------
 
@@ -61,6 +75,8 @@ The variable *$?* takes the following values
 +---+-----------------------------+
 | 0 | button list was shown       |
 +---+-----------------------------+
+| 0 | button monitor ended        |
++---+-----------------------------+
 | 1 | button not found            |
 +---+-----------------------------+
 | 1 | invalid arguments           |

-- 
2.55.0


