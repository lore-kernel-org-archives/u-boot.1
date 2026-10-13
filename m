Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF895CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 16:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B2DB80F4A;
	Tue, 13 Oct 2026 16:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0cjNTdbxTGh; Tue, 13 Oct 2026 16:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E72E080F3C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791910123;
	b=WWmTE2GaF27OKe6+JX0DOJfr7fDAPMM/+YomrY/SSiw1313rA68baGHGV/WOLjMY+e56
	 veq0zCfScce/n8vaVLXS93AaeAe9JMSyLy2wzCX7hBrKlxglUtzd3eFnlYjEaSzPyB/aU
	 IyIiCxwkhhonnSDU4y2Nl3boAIRdbWEaz+eWCTkj34aTbk08KOogxRgz3MLsk8Vb0720k
	 aMqP/9qaG9Y5sSVVj5mbUc6wEXhhoI1WeA7eSheSJduTrzGuxUPqMQyo7HeuyAtpI93YN
	 m6FuX1QMfcqpa8Vt+5Tr2PHIc+u+DtIPtaCC97hyqZBPOjcoS5D5bYjmDUnlmvLDs3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791910123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=E65aKvDH7fyPvJMtDvfRMQ2YQ3lvOI2ke4Khvx9BxoM=;
	b=CiR+u3mMUsGJVvqET14GpB7+n/RwuZF/kBQ8QVxwPPhSkXEr5qt3BUR0VuSk2yz6qDtu
	 u+cXbat0fYlZ4AoRHvAvIJZdCGxrwS/xvPq05kdXjmJ6sBx3/CHnEn9gc+vUOEjp8aqEN
	 /O73RX5j+6RLPRgL1OPLK4xGFGcp8fncxqKNZVnEiiDIL7154MCyVKcJcbksDnIZ+yLmq
	 J5AKvEYlKbeHpbzAsRG0WoHjiEXIgy2GLxojDb4wgy4jq3MxhGQfGOBBjszeRUIXmvAiD
	 JHvE9vY5vxJL992EPg7MFp5swvRMA2WrysnB1Qs/f8zgZa6dz8vjZ27w7evmJXDwMEw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791910123;
	bh=E65aKvDH7fyPvJMtDvfRMQ2YQ3lvOI2ke4Khvx9BxoM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=z0gxQo6BjkZqSmtLCJSN+tC8qwAzIjwBpSRSU9/FQacGRSwn3SI3BxOROiWZkJGF2
	 OGIZf3Mu0BG8Q+9X3XcfY8Pa8BGEMzpy7d23PdXWhpJ6Ef7f2piulNQFAwGGLkyi+U
	 lPu18oqBfGH1Yz1jFkFessQkG/dsMnnt9Cj2vfssbieRIU+X2TdJ8KWaH6nDuZhjNd
	 ewEcTifpVsP9rGnqq2nNLgidU5ILizcM2z21g8g1x9jb1Cdkchl61Wki51auvq/W48
	 gqVCTO4RdfTJhuvCmD2NtXMlbMEPHyk4CKvYC8wXks6ioOJhdhBWh/Uph7BgOSIVUs
	 1E6arDA/cSSDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E72E080F3C;
	Tue, 13 Oct 2026 16:48:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9609B1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D38840437
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zho91CzHnpYa for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 814B540422
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791909218;
 b=MS+ZpKQ8ND4sADgnhVtx7boXqQuRwOTbAg9eZTVRLSeEEk645SGDKC0Ss9ZlE0+6Rbfy
 YwMuxFJDQ8NZ8fViX5wEls4xqkcQ/c1q1su4awCEDTjrcH0v/73PDEIFMtdBgha7dbYw8
 O/WdKuvUmpctVGAuNwcLMAkTplDq50Q/1/Enc/XHrAXTgmIM0MuMSEeJI0tDM+iYnqBj+
 GnR58Lzm17k1+4Y1T8QrzlZ0w56i0jJnIfhCcFCyCeOkBu3ZCs8dRMjSBHRADubWkKJjO
 1y/vdPNWB1NpLMkG86JKEdu9f9y9vDVkJ5jULHOvUD/qmZW7DYJf2ml0MSWgIE0551A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791909218;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=E65aKvDH7fyPvJMtDvfRMQ2YQ3lvOI2ke4Khvx9BxoM=;
 b=PYNuu7Q5NpMMyE3B7xsWrSmaIwrSNfp+1MKlu1HOz3vcMVDXd3KyHtpdSkGeL0e4o8O/
 t7bXYB/CLmcxS19WlZzzrXmcygNxmVWiuEzOKyNmX3em4TcJyZ87ltt8zx8+/b5IyvghR
 TLNiu9l0rRghE+k5nGwmYh8tEQVEu3Vaa6slh5a4FMT+xhnVcxP6NHqBqprEIwrfvfnAx
 KP1njUAW78lwoeib0io1Zu7CIN9ILD66i72QgNU5IsixarCxiDaL22mEIrqCQHnMfwuje
 17KHaW+1F0J8o5roh8N4BfhSSif+JnNzlZUuEfW7rW3CWdyFwfA5wD1AnShFsfJKWug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DAhEoMmg; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DAhEoMmg
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 814B540422
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BC3E60A59;
 Tue, 13 Oct 2026 16:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C35FFC2BCFA;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791909216;
 bh=kNlqtyYor5NNtuvnwIMILXGjdVWLo5F3H0Psi31EGB4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=DAhEoMmg8T3Hw0AuF+yVPN2dm8JAqWG9CJUYxV5I37RgzE+4duxiYXx1G2aUoYJse
 MSwTM13E7OD+d/+BOdocwEFR5/AlgYsVsYrekstoa56Kt7q/gtyUO/kzYuY6KRKSvA
 y7zNt5Qz2RPYiLgxU39jgR5T9vwG2eNEk2p8SiBOcIFjTGVVw+N/I+ZJZtPrxZ4zRU
 ZsZc2FuXCs51zVJbApUTT8eM/KNbJlKDmjqYwGlYUwLPhR9dRgAp06fTER4KLKn6hJ
 5PmTgGmHlsgZuE5cE69/zjWtgG6QPCdp6RbePMNWpb5u9AJAm6+fm8yA6B26PQjLgu
 TrmVfPsjoGzpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA6CC6B0E;
 Tue, 13 Oct 2026 16:33:36 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH v3 0/4] cmd: button: add live monitor subcommand
Date: Tue, 13 Oct 2026 18:33:30 +0200
Message-Id: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WN0QqCMBhGX0V23R/bHM666j2ii01n/qFONh2F+
 O5tRhCElx+c75yFeOPQeHLOFuJMQI92iCM/ZKRq1XA3gHXchFNeMEo5aAF6niY7QIfBQG8HnKy
 DUmou67IQlS5IPI/ONPjcxNfbZ/tZP0w1JVsiWvTx+NrKgSXuG8n3IoEBg0LxUy6MZI2uL6Ozk
 eoVdsfK9iSVAv9xMbrr4kCBUtEIqYSSmv251nV9A0sf69MfAQAA
X-Change-ID: 20261002-b4-button-live-monitor-87b27d864cb6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791909215; l=1856;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=kNlqtyYor5NNtuvnwIMILXGjdVWLo5F3H0Psi31EGB4=;
 b=HtsPst38Tfhl0T7FrpM5Oi/qID1j8U6SslwIFSQzLCVgn7OU12qweSKFiVvLoUrIVAJlHsClD
 Vc0Kh9csJ3sDyA7vfW8ei8d3JL5UTI+hbjua2bhYO9zgwRPPtnE3G86
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

'button list' only prints the state once and exits which makes it
impractical to verify a button mapping on a mobile device.

Patch 1 moves the state printing into a shared helper.
Patch 2 adds a 'monitor' subcommand which redraws the state
of all buttons every 100ms until Ctrl-C is pressed or a timeout
expires (default 5s, 0 for none).
Patch 3 documents the new subcommand.
Patch 4 adds test for the monitor.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Changes in v3:
- Split the show_button_status() refactor out of the monitor patch
- Reword commit messages: mention Ctrl-C and the zero timeout
- Link to v2: https://patch.msgid.link/20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com

Changes in v2:
- Add Ctrl-C handling. Timeout of 0 now runs until Ctrl-C
- Use ANSI_* macros from ansi.h and plain \n instead of raw escapes
- Share state printing with "button list" (on/off/<inactive>/Error N)
  and probe all buttons once before the loop
- Match "monitor" with strcmp() and reject an invalid timeout
- Add documentation and sandbox tests
- Link to v1: https://patch.msgid.link/20261003-b4-button-live-monitor-v1-1-6a2934e71fbd@protonmail.com

---
Petr Hodina (4):
      cmd: button: factor out state printing from 'button list'
      cmd: button: add live monitor subcommand
      doc: button: document monitor subcommand
      test: button: add test for monitor subcommand

 cmd/button.c                 | 104 +++++++++++++++++++++++++++++++++++++++----
 doc/usage/cmd/button.rst     |  16 +++++++
 test/py/tests/test_button.py |  20 +++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-button-live-monitor-87b27d864cb6

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


