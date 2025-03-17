Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33880C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAEC811DF;
	Mon, 17 Mar 2025 17:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DoMAcecQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059D3800B3; Mon, 17 Mar 2025 17:15:11 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10CC80F70
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so3945163f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228108; x=1742832908; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OlYp+T/WrcCp147ydxryHYMEk/JNE5GvgNZjLLX92/8=;
 b=DoMAcecQTWmDKDOAJ38T6dGWhC+BvSpAQGWHT09JW/X39JK5siaiebtsXIf+Y/IDsu
 E7xyBbNtyK8DaY9bYKgDfVmxQzsO0N/VHNyxeWETw35xUHelylWaBCHWam77U5ttL/Xi
 8SWe1ZhgvYKLiJDPSkSO7jvgFLyynI6FbxfKla+waujCO5OY7S6bvd7U3PxYS/EPcvw0
 SnlDRSvpkZKhgsbVKWpr66POB0IFpGUEpG3QzQ1FVGZeLnOMagcPg0/1y4pCpUfbZRvw
 wZBl47XnbdGBLWzwMVVB0TNCUAJRpox/BmH6KzakrvBqyfGXsD1qcaI97qvZHrhrMVT6
 ujbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228108; x=1742832908;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OlYp+T/WrcCp147ydxryHYMEk/JNE5GvgNZjLLX92/8=;
 b=uawkUjnR4Aa2bUZqjo4//jf+PYPDHTcENSSUNQqLw2kD4hzY5E+dJEmOAYTVv3WImo
 kYD6Z+Pqk3sw5waC0SWNsrBwmQgkOSs7An8sMg5e7IfyeUGQwyQGcjXjucnANwDRsOt7
 QmRjUTnNsHX57gnb0zjwekoetyZ+TvzFGLTSQU11mVQpb5syx3VR3NQLZBcYvdq1CiKB
 M4QKU/SdIeF/qUI1xMTXXSVytG7vID6ct26g0vad+52Ym8WVny7Clv42stFu1TmDNCZZ
 jAUILMy9YrYVzHq5WF0UIhMAMqklo/1aMOnC2a3i6VEC0/oGUIsTpdjCmgPW9gK7J8ZA
 y+fg==
X-Gm-Message-State: AOJu0Yw6COIsP+dwFFwi7gjUMQ6N1cEj2BBDc/K7usvy2cBKi5W89LKU
 2JR10DAmZpDd6re+hWYcqhazGnBFH+U3ZXicyC45bUop6XpcC/QeapqkGGWc5Io=
X-Gm-Gg: ASbGncvm2h45TsXvpa/CXWo2D8pxPT0ktJiEG6Xqo60y5Fprq+gHZkdOhM8rDceTzyI
 gYnWjq77Bzv3r2lYuCyBof2C7UxmH7/9hdN5av806HLGqKno2P1PctwVVZ4m8bdrPWZliYXyUAd
 dZgIdBIebMbSa/YJzWOOEx9ua7nSqXcY6ymrr8Eqkv6sElMzXiTZtT0QkoLKzdCf8SnsbegdWUl
 uuKJxr3LJMzkrg46G1FmWAP1YWIZJqtLc8QRBpIXQ8j/NbgGwvn0sUFgs/8xqqm5h8+MnCHG7Nz
 1hHgu1c+mACAwCiF6RhtQY0ZRnZT5eq2yT8mek3Sy9Yk4O4uwvaN7KwnoQrH
X-Google-Smtp-Source: AGHT+IEdrIHAlcXkxaPK+jsodNQzW2nSw7yciLg3F6QnZzdeprI9u7oPmopftmttAzY44Xbg8MMgsQ==
X-Received: by 2002:a5d:47ae:0:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-3971e876615mr15190446f8f.21.1742228108001; 
 Mon, 17 Mar 2025 09:15:08 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888167bsm15382001f8f.45.2025.03.17.09.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:15:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] clk/qcom: fix UFS and MMC clock enable errors
Date: Mon, 17 Mar 2025 16:15:00 +0000
Message-Id: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRK2GcC/z2Oy07DMBQFfyXyGiM/Y5MV/4G6cG6Oi0UdF9+2Q
 qr674QWWM6RzmiugtELWEzDVXRcCpe2bqCfBkHvad1DlmVjYZTxyuogmYKJStZK8pxZ0qHRB8t
 g1eK9gvMhiu177Mjl6+592z244/O86U+PUcyJIanVWk7ToKAzudFnpNFgTnjR2WQ/0hyNRZxtA
 LQK4UddwZzuXdPwW+X+q1rHX9JFSyWRFu9cDGQjXg9lTb09t74Xu9vtG+jLRnP7AAAA
X-Change-ID: 20250317-sc7280-mmc-ufs-clocks-730d550e4578
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dUBBxNb/0o/lyAVsoojZAGq5B6OU/TtTrZkIkmyHC1E=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn2EqKIhE3hXe1SlLtEKhK6IShJFKyRfQQ4GmP0
 J8nNPdDTW+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9hKigAKCRAFgzErGV9k
 tjX5EACQcbQj8ylmzAvO9/mq7xsrE3H4sVajfzqn4HslpCwC//5xLOTfglzmWz/rV7gOy7H57KV
 TcOtVnM4vslYnQ3KccaZGTIwTZ9RRbRF7vkV6PE/1EKb5gWqwPxwKMdMnzu8vRMkHBNEbeAWghe
 EsLdcvE9FQ2vByDFjQmEzNdqbLuqzJFbOKJwfhSaLpAQbOD8tWb1n8Q+tIxs+HQZ2FPlL2WLBBL
 HrXdRQQWKfQj3t03DfVxEY5QAh2a95gTlxReEKg0mU2MD4+6h2cFxfBJ2SAne69J3krQ/QcXZZl
 q957M8AH6ThNlaMIJxXuGGD7ZRBvu8H3Skn87yWA9bRwahbvY9XvuB8ArnK35UKSu/mHrJYh+GM
 wqDcZ4BW9qlgl570KI2tR+l+0lPYCe/PDVJCSom8NmiKHqx0uPc6QQ2cCVwG+qgY7WV1C/ZxPc6
 NVbvl+4kzMC5PAzupwhzXGTy43KnkmCeEGhCvlAvH+1GaFpj6D3tdTXDS578L/pQhS4ty6qyNF+
 hj6sHLhDV0rUGfYEPhz9oQXNS7ZGqmSSSqPEcOQJxrBjq+sUIbByYU0hawgCz1HtPkDMsrobps6
 PgmfumdjGW1VmlbYACr7VgYX2UJ4e30KkHHLGkqjUqa69+aIHeIglRWHSJckN07sVXRo7soYdIk
 bp1Owwt1wNxKErA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

We're missing a few clocks that the MMC and UFS drivers try to enable on
SC7280. These aren't fatal (the clocks are actually already enabled by
the previous bootloader stage). But it's good practise to enable them
anyway.

This doesn't handle programming the RCGs (the parent clocks) since we
expect them to be enabled.

This depends on https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org

---
Caleb Connolly (2):
      clk/stub: add sc7280-rpmh clock
      clk/qcom: sc7280: add missing UFS and MMC clocks

 drivers/clk/clk-stub.c          |  1 +
 drivers/clk/qcom/clock-sc7280.c | 11 +++++++++++
 2 files changed, 12 insertions(+)
---
base-commit: 0e1fc465fea62ebae91f2f56cb823e8b37ee1077

Caleb Connolly <caleb.connolly@linaro.org>

