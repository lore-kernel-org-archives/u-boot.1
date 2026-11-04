Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C560D1861
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D5EFr+zv;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hJs44HNJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAC45607D5;
	Wed,  4 Nov 2026 19:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xC5wZqxz3x7; Wed,  4 Nov 2026 19:48:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E5CF060760
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793821732;
	b=nscHpEhCrOnZzn73P0pC87dhZ2FHfJZRYm7Veiz/BTQ2PvA8l0EB14W7XDr4Hw18VFy7
	 xLOMm6C5dJR7dtGvGWo9nlJKyMDzuV8JzuiwOVT9uRlsV3s8QjbKrc/oo9u0POQZeUgLu
	 94v3gncsBbyuWmiVVvgxURSMBtZv+3o/9jfemCK7+nd/AKoPoqpqg/XoKn22aht2NB39n
	 bVx/Twx4Rz3JEtMjSGVFAHtLC4xwmBxbAmrapwjPIOymt0TIrEMzcC7KewpSu+K+wUm0V
	 QDXoLkZhyyRQHcyNNXEOkGKf5f1pb8G+x8uyiNfDY2a057M7cDmgmnpLD8tMk8J7NjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793821732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z8/yEqmRJujr494lOW+DOei1MQzC5DbBr4m/9YvDjlk=;
	b=l6Ea7x7UOsGLstdoK186KbiVZLdywkbm4+T3eAQlVEoeKRF3VFcqk4+/7rG4J1V4+stM
	 Mxd+wSFeECdRCZsf+2wh2jEpOE1rYjBVv6iid1DmQiwM+f/ahPXRQldR33uU95q7L1fbM
	 TxGuFi90u6k7H+N0fVT+2MMCoK8qaxyZshHiSATXdDgO+zGlbabfzA8dq3WNfx1zpvcuw
	 D7Fcqe1/s5JDiAgv3EJCpy06AMz/NNa3HM/NQeOywbLTrTq+zuMByOiQRSyq064AD/KeA
	 shzYqq5a9K/AJLwqysO9e/tnvAYwVW19H0Jir2o4h6YSAYt8/cnS8V9Ccn9YWpe1hYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793821732;
	bh=Z8/yEqmRJujr494lOW+DOei1MQzC5DbBr4m/9YvDjlk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D5EFr+zvwDWyRTGSO3fjOB9bJPOaIlJ4GFLC8OC9JLgP02xQRjgtNOIcCBBbDTw24
	 dnxUegRXIiX5Zx2F9M/lU10S079Pi5Ui5CbFWdfD1SYHVMrCPyYC1rS2PSvXdeeYVW
	 /72z1+JA5W8OzCEVJjYh8WOFswRYL1cQCTvdTljuD83RWZJDOw4lEdNdz437xG1P+B
	 YzBEPcbOxQpBqSnxnGDmU+C2FhysoTf/6xxCzKPWEjCfVB1RmfGqCAzyjT+KeZ5lT7
	 /0Gqk+OHaqi7jE0RHovNoTXfpRDoxSuN5M4FZoDxwbyA4riNMKO3W9lOS0f2CwuIIY
	 TBKHocVhgBwNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5CF060760;
	Wed,  4 Nov 2026 19:48:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F00219C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E12E440934
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ShDRBC5NiSa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:48:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8E6D40932
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hJs44HNJ
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8E6D40932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:48:49 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-54465f79af8so9534721cf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793821728; x=1794426528;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z8/yEqmRJujr494lOW+DOei1MQzC5DbBr4m/9YvDjlk=;
 b=hJs44HNJtlVV0p6MX/H3HH8hSaDnQe/TQS805MQ5mw/YhLuD1zKekwCUKXQ/TkBZ4F
 dwF+XOJkkYg9+rAd7MqhKQWFbHkmnnKAKSAkPhA+pm20qUsinJgFhKqIAhVsrU8i0u09
 V4FexPfmKc/vafHLrXjGvaJAuxtnNTKduLizrfqZMMXA574lNsvYCzJ7A3Vp01stm3gT
 mKl9sSeGCTPg4JHycFpdQpfLBVrk2+pOEQW5XlGcJaOT2a7xazMZBUscVkQZ6X/9VA/F
 A2VXbNTEKgrJVmTY53iVDg8DbGoayTtV/u817yRp8QAtQeETrHVHBLTp96ssVAvMvHqu
 ypFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821728; x=1794426528;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z8/yEqmRJujr494lOW+DOei1MQzC5DbBr4m/9YvDjlk=;
 b=Eu4n9b84/6SUddLZl1/B2cwluCsmTswqgpyKscJHnyfmKB33M298AgIfO2RSBK1LeT
 Vwj3UdR/rL5/BWURVZOCamXw9kssfCxUtLsIDTsmspodp4NuzB85uP6WUNd4Kw9B4h1v
 p9fZ6wm7e1bVpk5pfaZsmnakNQ311rw2rV4D2b/Qm8/aGT0Xo67ckRLjjgqHaKIVaELz
 QU52RMIOCTkC3ADXZx/dBx7GicCuCcc8cD/Gu0UlYJSeBlYR7TijSMCbX12S6T+8pnQf
 jV0qYY5dYNR1tIz92/mOIHMRx2PH+KoPBpwFZEcczpjafqtVWD4Z5xrc/DL5Wp857+Tq
 9rnA==
X-Gm-Message-State: APuU4Z8t0CQPijGd4JOLChICS96B9hi8NRGjycZM7oitWFQ3n7BfJdnb
 6AARyYpBO9SJS3nabRptmyOBahdh9lgs9J1Jty+zYBmAzCqKJlijHfttRTMEtS+ny1GJJp6PZxs
 4Erg4uXg=
X-Gm-Gg: AYBFou2VVC6Nf5ymhP5lQDRZkV5BsxFK6Dgn9ly+8tzBjB69stmkRR/BqnfvfYDiaZy
 LAXC75d1coEqOz6UZ0zA9p3CwS9KwNxAeyeyKGma0pTQv5H9Nzip9EVLizSDEdZrCRAOqmMSrsf
 jUQz7HAxtw7bsGw/ag+8xIjVwzrMADJYVZc9Gro9gMgE93B9GtDms3LEH2f6bYWhXJqrO9dUKyL
 akU8HK4dR56Ds32d60eU0xNhkWyuuB2JUNEtsCGkrhL95c+DqyEWQDRoZyVhcXDz7eGIBpz/lke
 0zFXcBd5wn1IZC0ywlhMEQXQs5e9yS5YsE3CZiGzZt2WTQsKjcP4P9jNInhWy/prenSxwr/LlY4
 3tKe1E3ycNmwr51KoNU4VusgsauQukDM5reCa2jhl/ANNhF//JunmJDkpvYj71aOnfXEJz4lMGJ
 5X4fK/nqVkTiXMjt+cUTSXWr544J9iuK6sjnGpKKurH/ItKRQ4i/gX/xnlRTpr4ZcJZslEOxQiF
 8WYawMa6y7Xu5OhjqQgCbh1yla9alb6fCgMsy6XlM0dffhuPqBD3mHkoF4oG7PsN+d/hOc2/KdW
 fd2g8Bg2AnVMNsRBH0ipQATNHo3TxzgPtL90uVEBJh7L2N/VYJ8eHXNIW7uQSiMx1mXcaSQJzV/
 mzlNo8VWSCSuBRE+xoyZeMXj8oA==
X-Received: by 2002:a05:622a:1e1b:b0:536:6bbc:6170 with SMTP id
 d75a77b69052e-542b6f4e135mr287010661cf.29.1793821727716; 
 Wed, 04 Nov 2026 11:48:47 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b10c48836sm32252871cf.21.2026.11.04.11.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:48:46 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 04 Nov 2026 14:48:39 -0500
Subject: [PATCH v2] doc: develop/sending_patches: add tips for series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
X-B4-Tracking: v=1; b=H4sIABaM62oC/32NQQ6CMBBFr0Jm7RhaSUVX3sOwKO0UxpiWdJBoC
 HcXcO/yJe+/P4NQZhK4FjNkmlg4xRX0oQDX29gRsl8ZdKmNKnWNPjkUip5jh4MdXU+C/mQrUwU
 K4VLDuhwyBX7v1XvzY3m1D3LjltqMnmVM+bPfTmrz/j9MChUa05ZBtfpsPN2eHG1Ox5Q7aJZl+
 QJ6iiaXyQAAAA==
X-Change-ID: 20261028-doc-sending-patches-d3a464feff98
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, E Shattow <e@freeshell.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1793821726; l=3126;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=eXNTuX+lSYyBX/siiXYUyGem8AVZ6g5W+dSdn98k6pQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGOfAf64umm2kVX2KMuydGEelyYP68twsfOOhCZJM77ZoqrjUYlTPx34eMwWgguheIPA6JVyFFm
 ly4WqV938ogg=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Related patches can be grouped into a "patch series". Add some tips on
how to decide how much belongs into a "patch series".

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: E Shattow <e@freeshell.de>
--
Changes for v2:
- small wording changes to help non-native English speakers
- add R-b

Link to v1:
https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org

---
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/develop/sending_patches.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index b4f82eb18e1..92bb2e203b8 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,38 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+Tips for creating patch series
+------------------------------
+
+A series of related patches can be sent as a "patch series", as described
+above. Individual patches should be small and self contained. Likewise,
+this also applies to each "patch series". Keep the following in mind:
+
+* large series are harder to review. Maintainers are busy and may postpone
+  large reviews, whereas smaller reviews are more easily accommodated.
+
+* tools like ``b4`` and ``patman`` will collect reviewers for each patch,
+  but then send the entire series to all reviewers found. This is not ideal
+  since it floods maintainers with patches they might not care about.
+
+A better approach is to break up a large series into smaller sub-series,
+for example by subsystem (clock, pinctrl, reset, etc.). This allows better
+targeting of only the relevant reviewers for each sub-series.
+
+Of course there are sometimes cases where a large patch series is okay:
+
+* when the changes are all in a specific area: for example when fixing a bug
+  in a driver, but also doing some refactoring or cleanup in the same code
+
+* when there are unavoidable dependencies between patches: keeping them
+  together avoids having to explain how multiple series are dependent
+
+In summary, the goal should be to break up changes into smaller pieces,
+so the change can be more easily understood by reviewers. Combining multiple
+patches into a series makes sense as a way of grouping related changes, but
+if this results in a very large number of reviewers (eg. 25 or more) then
+the series should probably be split into smaller sub pieces.
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261028-doc-sending-patches-d3a464feff98

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

