Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC90CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 13:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 253F660A52;
	Sat, 10 Oct 2026 13:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7C8wX3uKKK31; Sat, 10 Oct 2026 13:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FA3760A45
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791638099;
	b=cksS0L8rzCUe8NPLPemJPBCkflnRajpgJlpQCnc6LUPhD86AwdYMMDOkR+ZWZ9DWCbnQ
	 oNYGgBlCMnOJ3BV9BLNcGI1taZR8/Yo8bAOsKDGd2fQSWxO6/AXzbZXjcYYfR7zYOy8fu
	 vPmIOecmotIQOKJFMpPLvKhWjd0f+uuaKmAo2P0gznMaKoDjKQtJde5PHpCce+sJFngKY
	 waXVT+td45/Bh3QmJnGanKQ0hi6ss3UJOmGAYRpIxO5RT94tyMBLUO5f1NEvgzpGs2xFc
	 Dzk1Trdlxi56PSywKXMqKD0JGtA4IruofCib7BrAW1Ef8HgILsL8pPY5QAcTHC/iD+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791638099;
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
	b=rWzha14OPfjPU4X0You3odY+zAGVEJqUGx6GIVYRmFARbnMlK+t+qyYHtQzw7jQmsgPp
	 SBdi/z0vEKW4FQQlYxccAig49pFvIikUTs29GnDFS7jL3/Fsn1trBlISkLsD6j1+h9V5F
	 fyaKO+g+gD/ZD9V3kYfGjlAbaBoq2f+wlVkIVDJkw57ha9AK0B/80XSnOEd0ImCmtindT
	 A9+wYXtDq5RWtFt31R9sGmg651bC22flw/xlx3c492NXk3n8XJkpc7pYqoYMQulkRwOrp
	 FFfEh+sx7VFzYtnHr5eTKH7TZ6Ji2oeLv7dNlE1q9su/upLDC+bj150yP/QuuPJeX2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iZTfNvL1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791638099;
	bh=+pZ1epby9FlDq506o9BUn3h85MJWV6qJHcMUEGC2CJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DT+kjvwKjxT5/HGs+uNm9UbCbj1AxouKRdPp0WhtYcsdotrNiWrVUxT+Qmj2RvLTo
	 oD8JrBiZgbj0hoLVqQxAuAPqZM1VtLnZ+7KVlqJpz2id1x1r+zpUsHW7FAbjoRLhxL
	 LEfdlbdo/EFIwUMWrFRx4OHTInqcgcFjABjqYDa0VqJmGE5lQ5CqL2HanhWZpiopOh
	 xUjQErKxi7vVg5F0JLagX0OrSYY9EDQ//Ez9f1jKO6JHVPYfSMxfewQLRqfIf+cRfN
	 xOhTtI5XNZ73/ROdr0Dk2YBQ/DfVFB0cOON5js+nyK5nILQ3NR8iRglQcKhDaEIkX1
	 Dbc4yFv4tzk+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FA3760A45;
	Sat, 10 Oct 2026 13:14:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E726DE0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D88C6063A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZfZqeYgPaZ5 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ADF86062A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791635301;
 b=RFOs7SiCr5tMLwHPiD5URwAO7fupgTEmHjBYGxTJxkn/b1j5evqa7croQ/uofANYAAUT
 7qJ5+YpW8XnANxCSDMvB8QepSyTNRubbT9UV/Icu2LsDY8BASufPLwYafuNSzMecv2zjw
 /fPs228h198sydsr7cZGEt9uf1+dRsnq2goJGhEgnfrSg5QACe4qOOV+2JE//gLBkfzY5
 ysbH1+74dcRU9JU3YFMuPSUQqif7K5tbCtWWUmfnPMGhf6I+TRR3ILbXZjZY/5xDgHDCc
 ebb/QT/+cMoNsC6fCcBpzJKG7w93IJZ0ga+Hc0jkkPA2aQrqdGeHZ8IrGQ5MVHUWZ6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791635301;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=+pZ1epby9FlDq506o9BUn3h85MJWV6qJHcMUEGC2CJ0=;
 b=BLf+Wpna5O2NOUS0EAEI+LWYgcg7X+PJBn1NIFNEKu8brKsBeEUpKKhWYSUxs+BZWuyC
 bpews6pZK/mwv5BlReqdwLtDdA4bqVDNur9TSjp7T+DVJN/ApGdLxMguknGTv/sb0f3L5
 k3CGKQZGk+Au8wmxYTUUoDyEVgjQqt6vT0W1rdsQaIQvxl10uJU/kqYOATHKrXNVBDsM5
 PhjKEiYjjMym0LdYkygrwQK70gNpuJ0eSIxJNjQw/RprpMoB+B3VmD8nVTev7GfeCKY2c
 Q+NZqJSDVa+EjgppjKElfKSzL4GBfWBc4A+o54cfezFmC2v9jB9OjJNTmstIrHqqxRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iZTfNvL1; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iZTfNvL1
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ADF86062A
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:28:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D9694400C;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE41C2BCFA;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791635300;
 bh=Bvu/hr4Q2MuVcZtS0O7U4GlV3AobnGBPK4GrWvM9nQg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=iZTfNvL1ZdMK8ZCBUKMg6MWD13EzXP0JetaKmymToIBVubQYoWkT/OZ5/JKlfwrtm
 hLFJ9bgIZqFQk3PrfEEBQSk+ch2B6o0954jKjEG5qp4/cF0uDmOWAxS/8vnjVf/NCM
 VUlZsa+iBYG0B8r5J2xjNhqEzTb/gD9Usy40WSL/VpfdBFyXG3xxp7k6XJRdmaebLS
 BvrSqVPbUOoLn1ruYIuuMoSE4ESVLaQZKCk0vyZ3daieTotzmowY6+Ar7QFYAx3GeK
 5+JZNKPd7RWb5ZB4FLNVdijVhG+wavxmD3A7zcJ/79bY1m91XPs71Q/dpEo0b74OFb
 7NvC18OmMR5vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 44DE9CA9EC7;
 Sat, 10 Oct 2026 12:28:20 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 14:27:54 +0200
Subject: [PATCH v2 3/3] test: button: add test for monitor subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-button-live-monitor-v2-3-004f47a4a7b1@protonmail.com>
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791635299; l=1455;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=QehWb3NebKCgyG7BwGaStqQlAJLjXcbgvj4YCLBcWUM=;
 b=UwoeLB13rh8+NZNLOhOX0t2jmyLyq4aXeYxcglZbhkn8bFqITgAPF5dL5xUelM5LOBQPoJ4Qs
 V+SsivmijWsD/wRWCTAADWZTPC7OKWbFdpWnwQvRW5HsEwCOy4iJ3nJ
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


