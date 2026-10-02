Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E78CA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF506607F8;
	Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1XaSN8Km9CA; Fri,  2 Oct 2026 01:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3C7E60B52
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790903041;
	b=G57N9v70FDX+sD9F40qfIVfqOejtz6a9cg0334p/FrwQPmS9hBKcbeWFYzu9KbiPradR
	 e0xSf8N6n6rWf40i9bB+VW98PHO3D5tIYyLUkUlFHuuB5nZuBevDv4Q7QTY/WXeEdO4Y9
	 3vSgzW7OLhM3YftT4JrAWvKljKleKYuXTPn+gYj/6WKHbAk6ReeaEEi1e8jCVFduq2v1u
	 onCOX4BEBXSlhSNX3iCyKtnAsw1MAHCmxJpJU9FlOZnzVuFA1Bh0GX/KBzg72E79TFyjV
	 nw1vKH5z2uaLd6028c9kH4f+iC31S87/ZN5W50rdGxIK8p/UwjmcJ6jrw6X1IhjHB1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790903041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SJGz++QwAR8rB9A1DioiVCX58FB+vPlPzxH21jQYMtA=;
	b=DUomi6GDKo2lCE+wCIxSoRvgD1w6p4MX3tU2QrU+zHrzUjycLBSbbXTifYhzTrlC5oJD
	 lG/l2ybd22WlAZUJmu6wzEZtx9lpG7/x2eg1wj+rFFVols6yVaoV/lzywL29ac/H3jyuk
	 J3J1KBqc0SNZKJB0XU6YhvIVO38doGMDi46VBT5cc9VOpVB6Hj7h7ajojTgonAudbaHBk
	 SmOE2ISyJ/g0Syu/p87UHrLVfibZj1pOPBYNHgSUUiszBjNiwOO2HaC2vVAGz7gadq8NB
	 R/FYIiTt5dziPLVAXPB4ZhUXKd/C1OOFLU2ndOItSvivAkPWmN6QUfgfhDAkycDu74A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3mU9Ubo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790903041;
	bh=SJGz++QwAR8rB9A1DioiVCX58FB+vPlPzxH21jQYMtA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FOGXgPP5DsCT6bLxK9TXQYox0Nl0MdEa8eG9Oqk1wxgUV01jv4gDOqFndJKXktU7O
	 zQMyZ+eiNsswTKl348u9Vb+Qt0nUE+a17EZBE0bCENblZLYwHQ6LVwPeP6wxP1/3Ue
	 77bS4FLqOuPG6QHMdnGvFk9E3ooQziMKsyB4A6ZoRfz9v8AQbYoLQUjDjD1EsQVull
	 6c/08v5GKONT3gW8BwwKTPrynIR40/7BEBxtv/jTd3T0mXAT0TcrEczTYxTjaTmSjQ
	 ujQuaV30mcaavWnNrBAkdBxqvxYhBwHmxjpkLbdfJg7yk/Vq4EcgyMNr8EZcARziqx
	 +tPEsZ0N/72MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3C7E60B52;
	Fri,  2 Oct 2026 01:04:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23AA932F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09530607F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SM1XVMFSkQA8 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 01:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CBB460670
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790903038;
 b=a9pYAU4ly5YmSjojTcyzfLt3EEJJFX0eG4sNyK0oPkyumTPD7U9ggF1FleMff8Bh+Uba
 nBAJje5gdQhcyGDoEFWaUr9sP/PmGOpg6T500xFyN4ccwzwtMwLgXOjlJ6qN+G/WS6/8q
 cCIk35C8ARRZ2Vz8M8vR4j9uz/TNbcOhPSKyp80MVzjq6etPrzfwgwKvnkIX5pjSZQlec
 TpgRTiSqLU/HqieYAh80OCYug/JCiTN1OF1VPswHdVmd5481XkIw3Gf675kz8Uq9wVShN
 3Smi9i6qDzLcHyS3yIDEjTSZDNMmETqmRSG2pulFY4m9D3dObDvWGxVExJutV/atXgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790903038;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=SJGz++QwAR8rB9A1DioiVCX58FB+vPlPzxH21jQYMtA=;
 b=GHbGIBzvRYt1ER7JKOGC8dLjcCymv6IsME5x1gbKKfrsntS3JiDBg8EXCuoiXLsvZCwS
 IBBiDSi7afZP9yuzAMBWwW86f3BxAPyAsJ7S7erc5bgOMuw6iSOtGgWuGFy4egblRT8r2
 r0noxffzkfKBma04gtXd7ztW1WYyAQMArofpLJ85PyDWOKC5HRj2QFxo3QQJEt/vAX7J+
 5+RKeITBZJRpD1fCbS04jMm9p+fywmlKEU5ToLdSvkle4bFhRbtxj17shPmemQGaWDHcA
 So2WJ2EgfbHZjNNgqZ3HG0GxKwQtCG7sBueFvfK4zLCLmfW/wZdYwSUcz9gVm01Sdkg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P3mU9Ubo; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=P3mU9Ubo
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CBB460670
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 01:03:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9678C438D6;
 Fri,  2 Oct 2026 01:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F741F000FF;
 Fri,  2 Oct 2026 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790903036;
 bh=SJGz++QwAR8rB9A1DioiVCX58FB+vPlPzxH21jQYMtA=;
 h=From:Subject:Date:To:Cc;
 b=P3mU9UboOhYrTkDbERjjghIl6JFzAKKffrPWny1SRurn4Hjuciuw24h6tgHc7Pr72
 QF3bYggrbcntQsYrPWQG1pYEt1VI0F5xnM8rt1DaIkZb+9lmt2QLni608VdkV+4Ax0
 1agauY1MN3LShtsqxZ1N6z5xQUdYZ8v0HHH1iNLrjhaonfcqE6AZb03jB6X18OJdUf
 9nkqHWteUnKinKe1ehcekoT7NjaT0iUMTZfWhskWPXpi5TZTxO5J+m1oYU1e4PK7qi
 zM1a/OQ+lyIpD1l+rVpib55wgQj6pGD6v1EKmhep1gDLd6xdS2draqoLurpjdiALNu
 QX75C7N+fDofw==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Date: Fri, 02 Oct 2026 01:03:10 +0000
Message-Id: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07Zg+hIAr/8OwKGWAES2kg0RD+
 HcLxp3Lk9x7ziIYAyGLc7KIgDMxDT6CPiTCdda3CFRHFlrqTBZagZRQWSYHPFqHD5qgN5CbXKk
 iO6W1KUS8jgEbeu3aa/llflY3dNPm2hYd8TSE996d1bb7Jcz/xBzT0FglVdpoV6vq0mPweD8Oo
 RXluq4fYkfuNMsAAAA=
X-Change-ID: 20260921-00-basic-spacemit-k3-838119645d39
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=dlan@kernel.org;
 h=from:subject:message-id; bh=b6ETMEw4SQwNNLvoOpoV3LGbANHSWaO3sS78z2cnI94=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqvwLWXkrD5ff6Boh4HQu8fS3BGVeVO3HP8MsuP
 HvvmIPo1jCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCar8C1hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+042Q//TW6o1FESRyari45XwlYMRWshFMQsBDT35bpCmyCg5qk61pZcR5r5N
 O1WOqozJqowlUmQ8fp6NXp8ZtPxOM4msH3PLJtZHD4fjsib3miYN79gUXcfcXMUI+X6Qlp5I43y
 bj7FQr/MmglLe2ozv4MWxNKcOjwEUt34oELVOwsLqK7ZDBzc/EFzApR0a0EEpWcMVLn5Ps5PhKT
 5RkGUqI/OqnMuosA2koP3ROhIpTVtVTO1BqW33iRCSEEO2YjQSl9LyFlvr6q29VTpVlFpy7W2BV
 8rhxSdlSKzidPDRGVE/pWdpAuULZNwgZt4oMUFvrdH3X4za3mXJk0WyS5ckse8Ftxk6NG7anUqN
 IHMdiMwYFHB2UqOR63FDe8t0lqov+wY9gD76adr7pQX2+/1qIsvDL9sFKQC++hGW84jXeHD+K8E
 wOXwhmrrADJPNqThF0i6+Bw1JSviFWT9EO5OjMZVMWBokjZfl5MQPPm9d7rRCs5M/ABH+xbbq2g
 l9NdARJ3ms8nexmEF9BCeP7btmSTU/kq2EOICFNR54tR89WMn8PuSTBKSj8h6uerzuxn8OkNAN8
 nkm5YWm3ubHL0gb/4ZttuwzNTmCVITYWooaT22T6w1rYlC0bStRPl+gv081040xQS3x6/Vb8OrM
 Szq9A3LsGPiO+sZHGYrk+hRejkrDFo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Add initial support for SpacemiT K3 Pico-ITX board, the config file
will enable all basic components which make it able to run into U-Boot
serial console.

The series actually depend on previous sent patches, I'm not adding
dependency to this series, but list it here for reference.

Pinctrl:
 https://patch.msgid.link/20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org

GPIO:
 https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org

clock and reset:
 https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- drop board_get_usable_ram_top()
- drop empty source file
- Link to v1: https://patch.msgid.link/20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org

---
Yixun Lan (4):
      board: spacemit: add SpacemiT K3 Pico-ITX
      riscv: dts: spacemit: k3: add binman node
      configs: spacemit: Add K3 default configuration
      doc: spacemit: k3: Add Pico-ITX board

 arch/riscv/Kconfig                       |   5 +
 arch/riscv/cpu/k3/Kconfig                |  18 +++
 arch/riscv/cpu/k3/Makefile               |   5 +
 arch/riscv/cpu/k3/dram.c                 |  21 ++++
 arch/riscv/dts/k3-u-boot.dtsi            |   6 +
 board/spacemit/k3/Kconfig                |  30 +++++
 board/spacemit/k3/MAINTAINERS            |   8 ++
 configs/spacemit_k3_defconfig            |  50 ++++++++
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
 include/configs/k3.h                     |  13 ++
 11 files changed, 361 insertions(+)
---
base-commit: cf615aafae36fc49f55e3e6a3648d29201b26d51
change-id: 20260921-00-basic-spacemit-k3-838119645d39

Best regards,
--  
Yixun Lan <dlan@kernel.org>

