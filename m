Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C863ECCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14FF140A35;
	Fri, 16 Oct 2026 21:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnclV2dFhVIy; Fri, 16 Oct 2026 21:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 176B840A27
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184498;
	b=db2UMkgF97M7TAfjsDRHLzlgPLqxNTE8shJDLM8oD0tMCR6xLud5S/8NNXMNtQfDh76L
	 tp3acGyzOS0sZ9B34bk58y1EwYwE/lmow38RaKO0IUw3jMi/jcOejT89zQj1aAiXtj4HD
	 lplms5g2Chn+mqlW7Xo/cJhvVqb9j0ZnRiueebE3ceKwzXnFuczCkbh5SDZ/RV7OQmzMJ
	 iTNNbE7tGOZiNHKLKR74PioFQwCum/sJXRzOTNHfteEExcj9XRvC7V+UtC8ujqXgs2SbU
	 hIoVeq77HqH+hL7B0lNH0foexI0N94NBmncnvlDTRajjuRvY2nl1iOxWz4jzLw5mI+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=KQaKxdXIJePbCseF/2v6kRGnwemHv8/+U9rZL7pb9ns=;
	b=D42FG23oPjkdBjap7uAqRXocDU04K0r9++tK+hiXJbgf2Ls1oP84EiJBqUwwAwKICqsT
	 k5IoSxI3H9BHxcfEHc1+zK5iPx9mObVbrWQuQ9Ba/BR043hmKPnwkd0xLcyYV4W06V5JS
	 RSau5JapL4uguCb4gAN6uSjFq2Zx/6I79BxrUsTALnRJu4Yn/kYzvbxBFh3zJ8U5xSjQH
	 us4Hz9wrQZSHXQKN0N6+IOzrp29of4nyDyB8DE0C2vzeNnCotRDRWAendBaN1+XPtXJq5
	 jQxWVh9X/RaYn14ocTWCxqW+9rRf3QHbJT0vxqdR4IZX0XJH2BWUdKb6h4OE5mTPnKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184498;
	bh=KQaKxdXIJePbCseF/2v6kRGnwemHv8/+U9rZL7pb9ns=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=pD4BjTT/SnxFiEIB7s9B4AQJCn9kNSo+uK+7UmpDlEq5FsJDmrw69ctMeme2qHqHh
	 EIFUmZntU1iJKRK1c2AqciKOExjR/Nj6seKBmI9GQ/EWSMYsepNByIRehpI/O34pAe
	 6JiS6uqAfKSvyKcaMRobnyrUhAqMEWpMMozEri4EY8sH08cpqr+UsBN37VBET/gPXk
	 OIFmqa4je//CadD4q2oKf97XMzynWjcJKSGW2Zazu4isE3lRGvSYrvGWySUFQ2mJlk
	 JxEInu8yFk8qOFq/pC7g9ID3BKLJuVnZ3v346l060+F4qnMke8G3bEoKhZuJKqJ5Lr
	 R7NJLHwppYcGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 176B840A27;
	Fri, 16 Oct 2026 21:01:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF2ECDCF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F13814080A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHe6qKDo2Bul for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 20:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 49512409C9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792181644;
 b=p6rloYjMm3Re2U7hYBXn7cPl+0j8eRu2ftqU6zLgWqsB8uTIV6pneJdzXvCHshkxCdd2
 3DEe1j4BqgBFUSFpf14VwjQtVaLuQj+eTyS5rbr+RZJ5PMh3MNLbsu+vv1QODfFPa7J4F
 7nrjojgBClZJcBorFeYCepdCo05GcSMbvZywYtYC81gRgDtIAHvVjvneJyg7k2c8ndgSh
 9X644b+76k+V03UvZSiLaKyx3uMDiolBcogguOeseT6uvilrOFxkUwcbWPlkKM5fuJXLH
 Kj/BV7C1Gr0s8770YyNcPkm+TwxR2p+06prZVLKWfKhDNhKGW62kcQUiS9Y9RGhNpbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792181644;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=KQaKxdXIJePbCseF/2v6kRGnwemHv8/+U9rZL7pb9ns=;
 b=oyj0gjGSbdDIfLigXjN3aRt483UQ2kGAeWMkzsr4tiFcXA5i3WE4WUBeE+Rf8nexDjP+
 TOqmDNcEs08bbrFO7Vam6aFOIt3I+++kt9aCT3oWLq1fa/tqYK786IJonIk7K+4dkd/2E
 Ye3UcLUnY2rKFCegk/x53e3vcE3bhhIqrPs6iAvJkLg0FgSWS34n5OJsGLNH4PJJAgaJF
 aFbzKWR5GQHEj9YLuc/jGPLimWfxXVNKW64Pwo8mB5NsRWXTeEJRFl1ZKdsOW7GUDMzN2
 P2/wvcN7ihB7q1+Asf+jpnSX+EoxYiVIG+IxxeZ3HmbW3aPzLGd7ZeRfIpniDq1056g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U8ufReqB; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U8ufReqB
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49512409C9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A2D4402BB;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2440BC2BCF4;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792181642;
 bh=InkvlhzYHksg1npSo0OcjBFF+ncxgyp/zxriCIRZyuM=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=U8ufReqBFTcqsmShs+d8khDoiCC/waLyqE8QCF/tYMjqYKlIjdzUnN/D6fcItD1Av
 jK4ZqcSYPJ0nGSSpNHxr7plQFM+XzUNOWOK5hd/AGF9bg6Ci1J9CCPDSjHcmMq3j52
 k+JK0dd5Sf5rkY9AqLoIflYcAJKoK6ihp0vpjKN7RebrN+b1hMCx3LWh+1oGgM0dOE
 nH/0iALUMuAo244cYvqvINpawO+dJN2KWiR1sf1TQ7ip9KtpJqIBap7O7877F0CEs5
 vJ6EXfIobzEr2KbRX3SlAf9s5j9xGGr2AUd48tLaqeDc1MYYXhzpTLoL+XFA6+0U7I
 7ZefBR8fnOWgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E88C1CCF2C7;
 Fri, 16 Oct 2026 20:14:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 0/2] sdm845: prepare pinctrl and clock for QUP0 SE4 SPI
Date: Fri, 16 Oct 2026 22:13:49 +0200
Message-Id: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTNJpxZSvQphIe0AYyJiB4gJ4
 e5WWb7F/zsoJ2GFW7FD4k1UXlMGlQWE8T4NjBKzwRpbk6EaO4can95V+F7n7YLqkDzHcK28pWg
 gh3PiXj7/adOe1rV7cFh+JziOL7P5hG92AAAA
X-Change-ID: 20261016-b4-sdm845-qupv3-s4-18edc95821d0
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, David Wronek <david.wronek@mainlining.org>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792181640; l=1005;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=InkvlhzYHksg1npSo0OcjBFF+ncxgyp/zxriCIRZyuM=;
 b=4PxEnSzwIpVyOD9IvkFqAa7TtDCL+poPIhO4EI1ho23vFQlYwWN4TFzoWwsOPWIK6PhMFptbz
 eOc4BXxJi7MDCYI+XdHVcin5H7tZ1LOVb+UB8v+Ru6U7gTyOFEpkYoj
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:33 +0000
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

I'm working on a GENI SPI driver for QUPv3 platforms and the SPI
controller on SDM845 is QUP0 SE4. U-Boot can currently only describe
the UART9 pins on this SoC and its clock driver cannot set the SE4
rate.

The mux value of the SE4 pins differs per pin which the per-function
pinctrl table cannot express.

Therefore the first patch makes the lookup per pin.

The second patch lets the clock driver set the SE4 SPI clock rate.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (2):
      pinctrl: qcom: sdm845: select the mux value per pin
      clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case

 drivers/clk/qcom/clock-sdm845.c       | 10 ++++++--
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 45 +++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 7 deletions(-)
---
base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
change-id: 20261016-b4-sdm845-qupv3-s4-18edc95821d0

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


