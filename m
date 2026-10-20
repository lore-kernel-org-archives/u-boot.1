Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEA606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mqj0/KK7;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MlX+uL8x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56D4E60825;
	Tue, 20 Oct 2026 17:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPIhXV2VLUBA; Tue, 20 Oct 2026 17:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59BC3607DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517172;
	b=g7TvWwQ6xsYTnxgmU8VonPb2N+FzoyaW6cY712AVSyCw6hIYospXCLnaFBcgcTQO3L6w
	 95NzTMGvxA2GEENJc0m1TgAO0D+F36N6pFKijv3EOkYXkuPj//BJYu8beW3+SvpVoQEsv
	 RhOCcpXy5HDcks/WjZKxnRAF9h8fhUHw2f/Wo8TN8g5GTTKv40tnL2BuKRMgRRPgAnNvP
	 mga2zcRy0kyxQxt6ybPp5HET3Tbt5Vb4QNqPeaGg06woOtmFatHYzIS0vXityLnDhvAdW
	 g+YHwckdbk7sCWl3iZZ71iX3Jadj+1/ht2ZXWqe6eK+g4jVjJLXCi7NYo4vE/OwMOsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HOjPX9E7nQsuTQE5GL5GtkpcVg7xXptFDBpukl+R+sA=;
	b=kLgD15Qlunlq26x4XshIiw9+N/YUVl7do0Exer5IfgC1uYP2Oqr8zeK9fVplAPjvCnlL
	 uiwShVNQ8RdZgRRQsY3zVZqVwDuf8/mUWig2LnqZUQa0zXpk2+UckDB9NgGNiHvXtFAJY
	 D7ueOY+wlb7+phO9cmJcUmqnsLkn+bKxbvGkLhFJUxtswd8cC1bF3bdXPq+X7EWiXThyI
	 WVDylOwMn2dh7CSfo8cfY9bkfk8Pbs6ShY9D9j2kyxibdosDfEsXLETtCE2pCqU803l/w
	 vKL0dclC+kHWrp58ZCbW9AVzHukUU8A0AhL63RnLLcLKXw38q1DjUl3ZyUtIcXXteDA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517172;
	bh=HOjPX9E7nQsuTQE5GL5GtkpcVg7xXptFDBpukl+R+sA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mqj0/KK7CTjhIE7JJvesygFteHxlMZjuNYT35q4aGcmmXRKErT9MHs6bTgEW57yvf
	 4wLUEq6J/R2tybbjB7FQ6NmImN0sUhqcNJrOMFGcyeFc4uRPzemUv+xPXTaBeXTfyA
	 3CiAnWTGk4esr5X/KrC6lTAhstxRGfrZS3VQWKoq/dBDmIjg+DSD39qfswnO3nY+u2
	 2PkHj2cJbgNjEj9CNfEzFaucC8Vd1A7Lkcz2yiTGaNYO2GxIzr7VP84ShBSHNVn/fT
	 TGbdEiZ/yIEcY7Vwv4ou/Kz3DXMCXoZpilXQAAWS8xZF4aCATpHWKgPhcPeLTEMHs6
	 QPv1Z6FnWZt1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59BC3607DC;
	Tue, 20 Oct 2026 17:26:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA1FB3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D00AB810FE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YzinfXZvvYY for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C63AF810FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514518;
 b=MpY4Zi9ErdzrmfpFGgLMbx9LB6axCdrGwGsWVnqiLi9IfB1/oCnJ8TM20TqpLVcM0nTz
 iPiZUJ8emo9/WykiAYUysOBHzQ29Ew0H2NJbKESd5LlkVHXwnELh04j5jW9C9b0TTvMeK
 1BlF58Jgg+0Nzz/LBIzYNWsYXcXx+9SZdJG/Dmx+o89B95ZCnRy/oy4nQysl5moBoODMr
 PaPV/Qhqt85hdYiJxKXWfakYGmxJm4U6k1n8zTj650ERl/bA5cUqTk3cSuRAlxP3h5Q7M
 VD7H+b50bbfw8ZiYcb1l0MLi9rbgTaHeMl28ld7nfVCq2yPlj4cEFdTNHDqy/f4yA6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514518;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=HOjPX9E7nQsuTQE5GL5GtkpcVg7xXptFDBpukl+R+sA=;
 b=RSmk/qs3dEYFbUJqOCL7JSwb055BeS/8al/064uS4jL2rA5aVEreIAEYBxQrBpZcs2ae
 tuWMkzffbYwzstKuBu8YYhfh6KsEBZKHfbr0SgehK28MazaDYQwSdbaHMvhbe5zwGaGy/
 5LqWFH1vzBo2+Fzd7edkApb62mWzGrFAyFEhRdGKlkJ5XbW85Ah9CXwiFmC5LHplKFIRa
 475Cr5fmsOOWqgFyqOx9ZJ0uJ871X8vc1TIY0Wvr4b8FfCL7i/MOYKBNDGJdBdj633PGX
 uqEwUJlYtmPU+lwcFWRO5/K60GuZVGmtQW2wU/ZbrE0tsjBnJcxAAu8aWVm0CQR3cJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=MlX+uL8x; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=MlX+uL8x
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C63AF810FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:57 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso27993985e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514515; x=1793119315;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HOjPX9E7nQsuTQE5GL5GtkpcVg7xXptFDBpukl+R+sA=;
 b=MlX+uL8xmHWSDDZfUvUpbmN3ZZTra/N4fQKoRRV9Z6/zW4BSFM3CHCEQgTycJFKqon
 mKxayymizDWf8b0fuRVUpzVi1+jDfmaH9qNdLLZten8GNcGWsmXgurh7D0GeC3KogJPw
 /qIpjVpT6XtC1Z7SCLtNDJ9KIRTtMiUKD5YIo1pe6cIXnuDwSxvaMK+HDP8i1xlf/g1w
 8aC3wqrRo8G7TNh5V3+ed1RwnQt4DQPLx7Da3Cz4UnXgek8eYvOgI/y0v+Ay+RAkgll8
 aauH6G4e91c/asuTR8uXvcOHvEvd/+eEY8yZjXCYsPYpYhmtsZ7KIHmb1CyO0ooxUzFb
 8aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514515; x=1793119315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HOjPX9E7nQsuTQE5GL5GtkpcVg7xXptFDBpukl+R+sA=;
 b=VJFjvVmPvCVV88SA5g0voZSe7UAo9Mj1pmj6BynhSm4TcBMyEaR2gcbWOAWM9THm2r
 kLSBBhD0AVSCY5D4PCZVz156zmuiU+RYVQ2rI2YuRnpHvb3/ABN2d1NddoX5Lp1oArEs
 Bb9SUW/gLZFyDzBM+vSxuizoRxsgvibGz5TAVQypPMeNupmz+i1/CHhQMVy90xhyV0ki
 KFHUcnyKOWEsQGRlRtjGAqIJec5IZNFKpFvL2sVdE3p94C5K7V4tqC9fczmMT6SPQfVg
 U7+emjZNKAvB2M51m8fhiilVsRKkw5Ri+FryKF1RLBcl4i5uC/AjqdUAK8AFQA552MdN
 Vt5g==
X-Gm-Message-State: AFq9FYLd8nePgLrDnk2XgA9ftnEsciwNy7wFP89xiyKgAMmicj9EbfgH
 9OXcyeCLerQjo5pEL+Q/4QkaLN7JlQihhrJGDeSMa1qyts/VfG/fcaJH8/3KkfkeTrw=
X-Gm-Gg: AYBFou3XPfn8i5mFUmwMLDLKEvxBHQ6aHjaUWsrsbMtgKCbYQZVuiyYAfdoqw7ENrnG
 pOEIHeMBHEMe7uDzdtss890B60a1QykIVe56QIlD+P8qHa8kYeb3t23m1WBC+W5DfwxUVMc+Gdt
 lUYAfsKMr6Wx9MjfDoed2PBf0ZlmQ4WR4JxbIcur34I/XocPMJ0OviYrmqB8RW47d7xNl0LECCN
 fAAZmLINN1ZcppEFYSswrnICHu6eiefvTNxK5pDq0N/6i//cXl5MwUUblyJQa9bztXMoqVhWjn0
 HVgmsp80PRlJpXwi2dgKHdvcV4+rGFjr0NL8pLmvOvRyp9nju0ssQ9jBghreTEqXBFAQnP2gDm7
 p3ToxJNxBDDsQSToZ4svtFmBDeCcAeHMpmIY39BGLY/KG3nPZptWiuz80juZmXDfkVteGz872vs
 9kdJIJBu9ALY4bazuO7ki+IQ/DLtL41SEofxsR9sNfO6E6x/l2pIcOtHBqEV3H3qYdcNOpmOwCT
 4bG3BqEt/8sW87LFAHYpjZMuiC/MOv6ujUoFbeaBzYuAyLHIGv8R4JPWc59zMWw
X-Received: by 2002:a05:600c:3547:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a1d7608dcemr240004265e9.16.1792514515308; 
 Tue, 20 Oct 2026 09:41:55 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:54 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:53 +0400
Subject: [PATCH v3 06/23] lib: Track whether a phase has a decompressor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-6-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5793; i=alchark@flipper.net;
 h=from:subject:message-id; bh=8mamB7lUHbqGvl/vT928AIeLUtCYTMwo54o782ogTkU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7mK16vm5FuN89dvlpbW9005y2n+/xVn9PY9c+6WK
 N21Oqum0DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU17gzMsz0j/ua2/d8z8LHE6xedKfe3rDHXvPKmd6+VEXNS6zfgiYx/M9cFl5
 6rN1fbsmXA2xbTL0DV2co3eR+sbJ62qpH/y7zzWUCAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

spl_decompression_enabled() names the two algorithms SPL happened to
support, so every algorithm added to image_decomp() requires editing the
header. It also asks about CONFIG_SPL_* from a header included in every
phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
wrong phase.

Add a hidden per-phase symbol selected by any of the compression
algorithms and ask about that instead, which also matches how
image_decomp() gates its own cases.

SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c |  4 ++--
 include/spl.h        | 10 ----------
 lib/Kconfig          | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index a07c9a86d7d5..8dabd819998b 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -325,7 +325,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 	}
 
-	if (spl_decompression_enabled()) {
+	if (CONFIG_IS_ENABLED(DECOMPRESSION)) {
 		image_comp = spl_fit_image_get_comp(fit, node);
 		debug("%s ", genimg_get_comp_name(image_comp));
 	}
@@ -397,7 +397,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		read_offset = fit_offset + aligned_offset;
 
-		if (spl_decompression_enabled() &&
+		if (CONFIG_IS_ENABLED(DECOMPRESSION) &&
 		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
 			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		else
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5d..c5f48e27b0bd 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1210,16 +1210,6 @@ void spl_save_restore_data(void);
 int spl_load_fit_image(struct spl_image_info *spl_image,
 		       const struct legacy_img_hdr *header);
 
-/*
- * spl_decompression_enabled() - check decompression support is enabled for SPL build
- *
- * Returns  true  if decompression support is enabled, else False
- */
-static inline bool spl_decompression_enabled(void)
-{
-	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
-}
-
 /**
  * spl_write_upl_handoff() - Write a Universal Payload hand-off structure
  *
diff --git a/lib/Kconfig b/lib/Kconfig
index 5f4698f0795c..365776e05d80 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1010,6 +1010,7 @@ config SPL_BZIP2
 config SPL_LZ4
 	bool "Enable LZ4 decompression support in SPL"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in SPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -1019,6 +1020,7 @@ config SPL_LZ4
 config TPL_LZ4
 	bool "Enable LZ4 decompression support in TPL"
 	depends on TPL
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in TPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -1028,6 +1030,7 @@ config TPL_LZ4
 config VPL_LZ4
 	bool "Enable LZ4 decompression support in VPL"
 	depends on VPL
+	select VPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in VPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -1037,6 +1040,7 @@ config VPL_LZ4
 config SPL_LZMA
 	bool "Enable LZMA decompression support for SPL build"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for SPL boot.
 
@@ -1050,30 +1054,35 @@ config SPL_LZMA_SIZE_OPTIMIZATION
 config TPL_LZMA
 	bool "Enable LZMA decompression support for TPL build"
 	depends on TPL
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for TPL boot.
 
 config VPL_LZMA
 	bool "Enable LZMA decompression support for VPL build"
 	default y if LZMA
+	select VPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for VPL boot.
 
 config SPL_LZO
 	bool "Enable LZO decompression support in SPL"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for LZO compression algorithm in the SPL.
 
 config SPL_GZIP
 	bool "Enable gzip decompression support for SPL build"
 	select SPL_ZLIB
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for the GZIP compression algorithm for SPL boot.
 
 config TPL_GZIP
 	bool "Enable gzip decompression support for SPL build"
 	select TPL_ZLIB
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for the GZIP compression algorithm for TPL
 
@@ -1087,10 +1096,35 @@ config TPL_ZLIB
 	help
 	  This enables compression lib for TPL
 
+config SPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to SPL except
+	  SPL_BZIP2, whose library has no phase-aware build rule. Code which
+	  hands a buffer to image_decomp() without caring which algorithm
+	  produced it should depend on this, rather than list each algorithm
+	  in turn.
+
+	  Only the xPL phases have this symbol, so it is meant for xPL code:
+	  CONFIG_IS_ENABLED(DECOMPRESSION) is always false in U-Boot proper.
+
+config TPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to TPL. See
+	  SPL_DECOMPRESSION.
+
+config VPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to VPL. See
+	  SPL_DECOMPRESSION.
+
 config SPL_ZSTD
 	bool "Enable Zstandard decompression support in SPL"
 	depends on SPL
 	select SPL_XXHASH
+	select SPL_DECOMPRESSION
 	help
 	  This enables Zstandard decompression library in the SPL.
 

-- 
2.55.0

