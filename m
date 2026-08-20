Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23599C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5A5C607B1;
	Thu, 20 Aug 2026 12:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0aivSnNjbuh; Thu, 20 Aug 2026 12:45:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229922;
	bh=srRjf3OkFp7E5mjav9yZTujqrZMt/S/3lERFdHcGjec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ktBUCqmWKwl6sMT5ntUJimct4Uy1rDlottJBER3zOaCGT6KYM+FJ+Pc6cRAAb3mSl
	 bWxFFSZWOWVXLHsizHfGiISUDf5pN6Je/9wUa4AnPaEnyA5Z3qMbAxuos9tz5N8xZZ
	 AkYEsD6Y9RfrP6xdm3Vi+ucdahCh1Q7XYCfBbqjRVDEpXejkPiOpMxyhQ0Z9TFJRTt
	 SFk4dASToG21eRKY8QRsyYPV4KV4+c4IciLfCOYj46OZkLyWnICcbPFetZ3/x/fuca
	 vcIYe4JudE5opNxgIVacNLpXNxNxTNA0atx8SAKcMv+4ZetubL1qTlxtA7cId7Rb7S
	 6V/yhWdziMhLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D294F605D5;
	Thu, 20 Aug 2026 12:45:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB9363AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD8D140558
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vkMZVVHWlCjV for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:33:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YX+mA1/U
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C18154034F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:33:18 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1765087f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787229197; x=1787833997;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=srRjf3OkFp7E5mjav9yZTujqrZMt/S/3lERFdHcGjec=;
 b=YX+mA1/U6EQlbVY2XXzfsFMYNkOKoZ0rbKs67kTcF78EZUdNbkOfLwT941JO0PSEV4
 AlB8XwlhRPX6xQ1o/jJVp+x7PCepRFpJXz5eLpER3STZoYonAxYYcWChlsLqsxB9aG0S
 BfkQEiIOiyHv3xDhGMg1n2YPPjAco8RQGF3Y8VfJTZkkHIlLUDtXe4wLfbL1g7R1yg/9
 m+yVSn914E2kP4c10TZrZB3V5IC2CwCTSVRnNfnknONgRbuNN9vVV6T43m4WoPOqbYIl
 +4Rin6ZJeN5awoWKANixGMUl5M0NFciIJ0f5p9RJjmJ0xPiI2Mw+Kt79iOYtZRNuOpTk
 c3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229197; x=1787833997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=srRjf3OkFp7E5mjav9yZTujqrZMt/S/3lERFdHcGjec=;
 b=rX3d5sdy5niGslwHaay+EHAtwb+B0u294a0YZ6TJW3pBuv1kFOmPaGMcijZ4XiLBli
 xHzcy+O0lJcQGEbhhpKXQ1Vtcq4XECPqa8MM2Bq9yyobn6lQxBFKkxRq66vxKwI7PaEE
 EWxIiWwsz7IifCVojQsgonFzdbWdLgXe93Q2LOuqzNmP8kWlh+tQSxI8+alg4OvAJ85+
 s5p7lCX/kA1aahmHKN19q6Tjbl+Jyno8HVBfIXKbBW2VF/ww0aqkakEeOUp630c2+YMt
 ihWwtE4gXr2v+p2Qg840npKNuH1pkhojDSAnWOLD3wFWvfxklGURao47VpdePdYVXMqB
 LMHA==
X-Gm-Message-State: AOJu0YxS01FCDhnXJeVvNJRPZ8EPyVcfqf6kaeadN2syNNG3fR6r/F/j
 Mv/sXShP9p1C7j/mGwfiLlZSa4aJ2N9LocVy7PYJbMNcxJj8Tgbf8eFtjRIrnyTx
X-Gm-Gg: AR+sD13Tw/IMZTbg3z4gVTaQdD0M5wlhdSbG8RJuWQmiFfw9vhJuUoq8Pbup4AeByHY
 Gu1wrfUQz9Qo2/NP4fGL5X2AUlWkETzvW4YZNgCu8TY7IjzllBFYskYcCgF5pjeqMr+J8c03rvP
 VMehSXK/CWDpjK6prJJNZr/KymAb/0U7tB5LZ8P/Z1Wl0+shQ7VB8HdFefOoeYiqJ3JpXvDAB+N
 meD8ba6grhnj2YnbaXbWxD8MDMWxMYmtCLy4zlkzejGzhNW8NMVW9VphsgfUBE/ttJaIFxu06H8
 HkadagCRnf1ku1WUCP0kmu22lZledjC/rk0A5yOmxFvb9N5YB6zw//CrEUEtLmrkHrQF5SldZUE
 sFV1lQ3rxi51dV/qB270wJNdMXez8MX2UbFpHOtkLhT+IwsgsvpsVcsI/zLNTCHwa+b66ToDBCO
 rkyp4OiiIYWvdsDLXXxzxjjltghSno+rWQUO4kkFzofJjFmOYOsHVF7yl1X+qZh8Zkv6DCklPRp
 5m0Si7Ci7t9t7ZmY6MwzfZWQku2+nJxCGVYL8fiqvgfC/cOVU4WlNMiz96VIrhrYQJIJKKes/g7
 syhI58rwk09hnw38ZVXp2G50
X-Received: by 2002:a05:600c:8b27:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-499aa199601mr239910145e9.5.1787229196609; 
 Thu, 20 Aug 2026 05:33:16 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784a4sm139126845e9.1.2026.08.20.05.33.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 05:33:16 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 0/2] net: bootp: bound DHCP option parsing by the received
 packet length
Date: Thu, 20 Aug 2026 13:33:13 +0100
Message-ID: <20260820123315.9272-1-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220817.11754-1-pranavkasthuri@gmail.com>
References: <20260815220817.11754-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:45:19 +0000
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

Jerome pointed out on v1 that bounding dhcp_packet_process_options()
by the received length isn't enough on its own: dhcp_process_options()
itself reads the option-length byte and the option payload without
checking either is inside [popt, end), so a packet truncated right
after an option code byte (or with a length byte that overruns the
buffer) still walks off the end even with the outer bound fixed.

v2 adds a prerequisite patch (1/2) that closes that inner gap first,
then rebases the original outer-bound fix (2/2, unchanged from v1) on
top of it. With both applied, a short reply now stops parsing at the
first truncated option instead of reading past the receive buffer,
regardless of whether the truncation lands on the outer BOOTP_HDR_SIZE
boundary or inside an individual option.

Both patches are checkpatch --strict clean and build warning-free at
W=1 for net/bootp.o; a full sandbox build also succeeds.

Pranav Rajendran (2):
  net: bootp: validate DHCP option length before parsing it
  net: bootp: bound DHCP option parsing by the received packet length

 net/bootp.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.50.1 (Apple Git-155)

