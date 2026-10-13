Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A788ACC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119C080C53;
	Tue, 13 Oct 2026 16:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PR9ajIsAnE29; Tue, 13 Oct 2026 16:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B17F80DDF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910115;
	b=WteHiOViikvaCd26g5pb5xHVm6EKgfyrbdJcwRdauy+xDKyIuLs/io7SOQadgHyuKR02
	 A07AS6UUWnCqN47gR7UqYiyvdOXQCbD2V/IBDXS/gMoyZnSn0GLcaB1zst5PeoXqoMdG6
	 1u5xF0uiR17v21sdWn1zi4HrQTV2GK3lA2e8H8sg8Ha5WI+xcp9c1v5KX2Lc+N7Xe+bcK
	 i4xQxYOFWDh8ReevScFTD72aSh5PeqbbAmQj6SxA5hjDrwcA9frp0aZcnWrT3XlqrrFqn
	 Tpm/1xrUraKQzrFJfNfzeL7Oo0doL2CP/i4QRN6BuaagQ0UcbH9V8vVlL3CSnwg2jgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=+pZ1epby9FlDq506o9BUn3h85MJWV6qJHcMUEGC2CJ0=;
	b=CkrHoKmv1PSFQEOzv2J7OBM5bhE/hWn0cmwT4+b29A2TiZX05AGet9MOVp7wAhQWc1WS
	 m/9oBCZ+VSwcMVbabrvoZUF1ExvK//DeOTFXGoN2pgg3YgQFwfaTvrpOURz9yNSvFyvaY
	 1er+VOoSQ6gkveQlVvdRpbII404IlxCPC/6AnjFti6PW22nkqXLXKJPht5Qqpfu27uJeY
	 zyEvDy4clER6utjWJ5OqYNxjKR7XZ0mc/NK+sB7YNrF6RDBel79C4Fq9MPMvjCYlE5B5p
	 zbpvLJ1ZpI8iwdG2FEDFBBYNz5tUDx+Q/JEtv5uwUXfUWXHOmONXEzxYzyGuuO72GFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="B/6Uznbd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910115;
	bh=+pZ1epby9FlDq506o9BUn3h85MJWV6qJHcMUEGC2CJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=z24Qb/cJcBl4ovjl2jltIFoQ06OVWepEITP9OL5edBR3NNZK3vRa7BOH0JLxUo3YA
	 HkSJkFKVyVbJU6JJjoCur8QMNMUYJ+X35RjNL3XOrWec9J3HGq7QLcyL4jZ0dnMP+J
	 2he6OTV/i6tJ9ZqVrbE1qi3DjFn7jppONqFkF79nSHOz16W4DVurqiSemzEhluBj2n
	 JI6Ipji45MMHY/ycJX7qulypz4bcQSk/jUR1c4F/+ZXzHFaWlq/aG9461/jA/Wt+Kx
	 hiVLWzWBqYLxpBpJLeEeFOBKjcB8FH0/Bj/VeEXoCrvlZN4EDAb+dYRXppscnVNkny
	 vDgd+VVuyBBWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B17F80DDF;
	Tue, 13 Oct 2026 16:48:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46962129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D4DC80C16
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yl52xmlFsezc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8119680898
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909218;
 b=WwFmGoP4TZsuURlGoZ7unAe3T711lRICRj1dcGxTaUoGnG9mUfE1jeCtAL+AjeROIl+S
 118dmV7AcyCVVpVbakUpCu8gQaJV+jPloCu4XSUYE7q/mFOaMJWBcP/UkL1OU1Z7iwsMC
 aGqyzOrTLqKMN78vXue/nNjwqNM7SwcVk9MuecUYA92HSXBrUr2cnlRZVUbyx6mpAx6j2
 0vDeagl0iQcH9v3UQ8FTvh1J7/oSHOeyFf1OH1XRGgFnA2KN8QRvySsSdhZHc4xWyGy0l
 7Dwb4K3DDpadEmEw7xlKan42OSoK3u2UA2hFRyO6FfTJ162iIVWWisbx1/Yka2I5lxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909218;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=+pZ1epby9FlDq506o9BUn3h85MJWV6qJHcMUEGC2CJ0=;
 b=LskTAjrHrwk8I3r+UE0qNlK8b+MW7QFwHHJO9HXJ3cXjpvCSh4LhDbD2F4/aYRWqFBNq
 PCNALl9RTpiPekI86c2QkLF10Wp3V3YO/2s2O2bSYMT8ty6wzCmrRqqiZriyOIQRM1pf5
 YJt0VOVBQ6mn4EW/4xucb3tKOs1yrdZKZKSxg+yww0T41ejTylY7Phj0DMWwBFuEwsHcR
 gVbnykuJAqsfjXpzFky3uZ6z5MpECmytgJ4NeMgzNDNLfJqzcJhgN8N+MFmEzwHbwq9b9
 +eLpBZ+UCoh3e2P2NjND+3WmSc745jIRFwIyCVJosfCn9K9pq/MO1Z+2LKqpFMqp83A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="B/6Uznbd"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B/6Uznbd
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8119680898
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DE534387E;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13B3BC2BCFB;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791909217;
 bh=Bvu/hr4Q2MuVcZtS0O7U4GlV3AobnGBPK4GrWvM9nQg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=B/6UznbdizTlUfTl7XhV+DhFWzTUsRZP571W8pfmDByo1PIyRARG+Bge61Wi1HX3k
 5ex7OoNeXO53hYLWDUY1MHzUeJyvk66eNCgQGe6IG2j1bcx0mrE1tIjZtVYb9FjqRB
 cp8KfkRkTOymjfBVByCwdSN2IA6T3Rg6lsAqc3UqdUHe23cmqKj3WfxdCIIy62m29d
 lORLjN1kyIjHSVQQWt6zNvgqNkSdasMS+46ar6Rfx3rpCZrELZ/XRobaQJ5c44aB3Z
 CYESGnjFzdzgsWJZXTfJarPT1p3pk81n68wGYUy8tUr9sLJcIDlFhkTjvBaff4HnBX
 pfvNMSud9+PqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 02691CC6B0E;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Tue, 13 Oct 2026 18:33:34 +0200
Subject: [PATCH v3 4/4] test: button: add test for monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-button-live-monitor-v3-4-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
In-Reply-To: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791909215; l=1455;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=QehWb3NebKCgyG7BwGaStqQlAJLjXcbgvj4YCLBcWUM=;
 b=qeRtk62QhRfOtkQe6hdMYCfXPJiErQk3MQO6s1KO3vOwg8LEe34ZZU+BO7LpxgOKjmfAf+81p
 ntD/kNJWvPsDK91mGcspynLpIxJ4Te1K2pwaNasCZ6IK8oC7qWNAKMq
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 16:48:30 +0000
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

Run 'button monitor 200' on sandbox and check that the output lists
button1 and button2 and that the command returns 0 after the timeout.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/py/tests/test_button.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
index f3f68169e14..494c7956543 100644
--- a/test/py/tests/test_button.py
+++ b/test/py/tests/test_button.py
@@ -37,3 +37,23 @@ def test_button_return_code(ubman):
     response = ubman.run_command('button nonexistent-button; echo rc:$?')
     assert('not found' in response)
     assert('rc:1' in response)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_button')
+def test_button_monitor(ubman):
+    """Test the live monitor shows all buttons and exits on timeout"""
+
+    response = ubman.run_command('button monitor 200; echo rc:$?')
+    assert('Button monitor' in response)
+    assert('button1' in response)
+    assert('button2' in response)
+    assert('rc:0' in response)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_button')
+def test_button_monitor_bad_timeout(ubman):
+    """Test that an invalid monitor timeout is rejected"""
+
+    response = ubman.run_command('button monitor abc; echo rc:$?')
+    assert('Button monitor' not in response)
+    assert('rc:1' in response)

-- 
2.55.0


