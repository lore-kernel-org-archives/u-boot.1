Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBE606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pn5B9nKl;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=LBrYNXs6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E69528136F;
	Thu, 19 Nov 2026 16:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFhxWz_EE90u; Thu, 19 Nov 2026 16:53:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A9BA811F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107219;
	b=kRq6sR6yawyhSglxBzayG8mPeWEcIhuONcwDTaMgPXu/Y4Bu7EPRvZ9n4N+ZoBaWU8Km
	 GjWumWAVHllmgohOz6mg0TKXZzg3luanEG43W+aRycrPHLDMkxgN/Gvztgjoki93RgChO
	 rNKqL7wGz6k1ItQNhrZcmEm5LTEPFYkE82P8sRwRpSwHpsfYJARdZB+4nNfBNcTOSz4ym
	 aENFrWAq7TKbLZRvYZs+3rzKYpQAuUJt919IOf20rM3frT2R6ybQbBQavBvR5+KxQWRyq
	 jucDvYG2jR1bsD6UvjfRnVCzBlLUZnLss4RE5wCetRrt+9P5klU9D/rbm49aOJRBMCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/5yN9O87/vHYUOJL6MSXzkGR8Fkb38s9Yqa2PYaLlo4=;
	b=mJQu/b3vIUmLQW2tbvj6ycwyDHWYgbLKJCApgHznYhI3OoEXZjOQ1ATRiHhL5B0ZVZxL
	 oanYhgvBCrNZxHkgrZyabKiPcaIFViyX7w6bBY9eHylG+481x0ID1Y8aE62BkK89Hn8O+
	 tE+juFxNaM31ero8AbR0cIBlx4+DlQPe3jilM906IW9MOBhYEEDevHRc9HxqoORxjdejY
	 Yp8cjNAaYxbEBDhG/RsH/Ty9ScQdFoesKkf4/su/rf/eD0QsNAn8IqwcwQJsOPR6+SoHw
	 66/cCrS5kfFEq9XzqUP8W1uabSKS+o97N1oEiWmipk+oEyDnt5A5dAaihs1wrYZ9JmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107219;
	bh=/5yN9O87/vHYUOJL6MSXzkGR8Fkb38s9Yqa2PYaLlo4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pn5B9nKlmujZ4fpm3PYwIVD2Yoowpnj2JK7YFlgTXrMrQNLidfmCKRV+QduN9uLoz
	 gykK5X9O6WJndcC6vFV76qdYzmRQktW3vlkIOQb8wbcaRogKB+GzPxy2cupAw/n8ig
	 o7Y6+Hv3VVUEAafez7pwfSQkvNmdTBabcqTtBg9QOL5CAPGYsvaUtrPWSQm8PoQCCb
	 pI5laKbQ5B3v+4ZqbKmIRhMFLf00hT3D4mPO2zgvl+PQ1EszYmC8qgweTNwPyl8knM
	 cG5rc/yplwfcHuGfX7Cbpsbt9aBKDtOHamOltnsmxs7scnsEtfrW01gWAB6R5gFIKw
	 IsXmDEXjW+6NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A9BA811F7;
	Thu, 19 Nov 2026 16:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E0721C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B85C60687
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbIBCFNv0CWa for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EC1C60671
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:201:9162::2"
X-Greylist: delayed 318 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Nov 2026 16:53:36 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=LBrYNXs6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:201:9162::2;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EC1C60671
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795106895;
 bh=ebRykuJqz6hkeu2sq6hkynGAXjS1v4aW9UfL2g/qSCY=;
 h=From:Date:Subject:To:Cc:From;
 b=LBrYNXs69TvCE4dSKLZ5BPsiPY4xITIDFLc+hvUKChu1ldFy6212P6z2yqTIL+ErU
 /pat8VoONhKfow+oIoMPDt7F+ESKNLjdIYkGP8job3dGVVZlh+UBhqeGvDkvKnUYYh
 EGwpoCu3Z6LKun7ZpoXn6ZCDXFwkhTzFUP3jM3r0eoXxT769xUj5TzGqa52/jbfEfM
 e7uqput4460IYfztp0LEw88p1i7j/rUs8HJvFOjjseV3m64QVDRkXDJ8e67gxvhkgy
 Sp/kYxriiLPdlXLyJUJmVDBfzEF4eKmJYGyQMG7fOqwFz4B3+HRDl/WfOReHnqd79l
 R3i2BJB92bv7g==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 76C7517E00AF;
 Thu, 19 Nov 2026 17:48:15 +0100 (CET)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 19 Nov 2026 17:48:08 +0100
Subject: [PATCH] lib: sparse: call schedule() during image write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-sparse-schedule-v1-1-bb683a12f268@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrA2YkErrVcRFTH7rFFHJGCmId
 2+sy2/x3kGCyBBqioMidhZe5gxdFuRHN7+hOGSTqUyttX4pWV0UKPEjQpqg7KNy9gnTWxsoV2v
 EwN//se1uS+o/8Nu1ofP8ASFKnx5zAAAA
X-Change-ID: 20261119-sparse-schedule-450a48e2b44d
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=ebRykuJqz6hkeu2sq6hkynGAXjS1v4aW9UfL2g/qSCY=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBq/yhPm8iJ3U2Rv+yfWwL5lqltI8S/PEV5KCOm1
 6sXf/D8BhiJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCav8oTwAKCRDT67WWa7mR
 lm/iEACiS4zjGotBC8UrwEbcYCFQahXXB+ArPQHCTQneVpDtA8dQRR61c/ME2L9cszMYzcVhNpk
 FsloFnKRcMZ2Ynl3RU69eb+oq9NA5EBuEqpTNFQ+uCP3/2BgkJWkW5CfXmQZE7vpaKRTB7XkqRQ
 +uYWyFBBMsCNJcUGTyhoRQwSS/cXqSy44u88+Ij9xMMpZyxT4WS0Jxg/Tj4hfu5JI0rFCtnswre
 LJujnLuD15eX2TBqV7vRtXmEt8M7aOn2We6TYPL+7bvaookSbO3Rvo4B262uwGrMKES/2LQ5hOK
 hXMhIImZ/DKzhERjXoLhQUSaFr/I2gAPeGrok5C2TMsaeC67zX0vallHsIu1RpXZPdS/+eftAV/
 WJPAX46l/5ER1SlxihZG+W0tKbQlGZ4oRpST1jW6KLGu2UO7Ejf6e1ORik0N779VWqDVVIB3hmR
 YXWUPg6np4haet7PYgr8GqpCkOFJCdy9vj2RiKlusfEXDXcxGbGKQhjoUQcYESE+7uLjVZQBmWp
 hWOtdtT1RKsHfKHeFXVTvZdx8gsPLEATSyCuU96wGU1DaIPcCz8kAkIerRwVPRF5n/t1NtPpVfJ
 psiCXH4JVb1qwBKg7aVp/a2ArnlvFppooOD4zXGrQd3BlrynyjMDv4l5eYVYNi2awREtBqnsoC9
 ceiBmibvgJ4ihAw==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

On some platforms, with a big enough fastboot buffer, the WDT might
expire during the write, leaving the system in a broken state.

Calling schedule() (which in turn services the WDT) after each chunk is
processed ensures this doesn't happen anymore, without any noticeable
impact on performance.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
This was tested by flashing a 1.4GB image over USB on a Genio Pro 5100
EVK board with a 1GB buffer size, the longest write having taken ~24s,
well over the 15s WDT timeout.
---
 lib/image-sparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index 48e5d8ee869..1dfa469b814 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -303,6 +303,7 @@ int write_sparse_image(struct sparse_storage *info,
 			info->mssg("Unknown chunk type", response);
 			return -1;
 		}
+		schedule();
 	}
 
 	debug("Wrote %d blocks, expected to write %d blocks\n",

---
base-commit: fd64f94c4404609b9abef32494396dbaaacec62c
change-id: 20261119-sparse-schedule-450a48e2b44d

Best regards,
--  
Arnaud Ferraris <arnaud.ferraris@collabora.com>

