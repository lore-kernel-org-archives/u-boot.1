Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85995C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 10:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C39046074A;
	Tue,  1 Sep 2026 10:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5oJk86w90myx; Tue,  1 Sep 2026 10:21:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788258089;
	bh=8wO+nBYOJzOfrcH5BB60JtCusojGbn73B9LlWleZbg4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xErlcNbVPbnbPV4McUpmvL1BWSTK/OVVKCMtMXB8AiHTCDcrHfO4Z5Wv0bS5FhGg8
	 YrFtpV/FbcKUeOkXIzOt9XlDuwj02aUDphMhXvYszyI/hte5UXittBoflCfOBScOe8
	 Tijlp8T4zpDQq5nQTAa8+xPMrviq18dK+bE0pzPO/DZ/yE8OwPqj5rOjsMP47lXqIc
	 ah9iRaFKGSD3OExk4c863dQRU02Q9KrEe/Rprar1JOFNxp7Omu2U3svuU7jE52qPHn
	 TikyuL/phKx26PYVM02IfKYgD6M07NUDYK6KKk4GjBwzh3wR4p7htQ84+24BzOCIsr
	 CpooO+d3/In7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FB59600C4;
	Tue,  1 Sep 2026 10:21:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45B6D377
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 375F26073F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:21:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id citi_X0a5F4h for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 10:21:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=naveen.osdev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BxlhLLXH
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97FED606E5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 10:21:26 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so911861b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788258086; x=1788862886;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8wO+nBYOJzOfrcH5BB60JtCusojGbn73B9LlWleZbg4=;
 b=BxlhLLXHQGrkZT3Z39x//WcM+uXC/7/OGWFMiSe4fsGS0/3W4jdD8A9Z7Ys9G8hkOu
 AiJwo7/vJXto3vEKnQDTkxJPq0AKG8rHt8Rc4fxuvWdzza0HackoI0mhA0qWzVx3/Lob
 Tha0QICf9jkuVYOo05LWIm48NsWHK9iaMbw+tPSHJWFgZiZiCV/U9lRtikLW/jrja7l9
 eSGMXDhhF2BqmSjkPDOQ+UHkMITkjhOibI9CdraN28sQ4Th2oBm4vpUXES/Yg2Q7MLpJ
 DP6/e5HsML/BA6XDLP3ubS/CieXXGwPC1GT4b4H5sdhKsJsvX/6T/hF2DDDkX/GQxLsA
 AYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788258086; x=1788862886;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8wO+nBYOJzOfrcH5BB60JtCusojGbn73B9LlWleZbg4=;
 b=MKlExRgQyEC1fCb+yibYBGIP3mY7sDAEUntuJnXnfQ7pj5AWg/R9m8SRi0wBFiMCBj
 p04qrCbdNo/jdJhlb2fCUl4Mo11KCfZtvafOvfDlTF5y9wj6R1kM4Oxc2mtFQe5QmMVh
 xkBv7t5bIHrNXji5o3BnxVObVKxLhJmDJ1eyYuwnfWPSQLAMzha8ZqG3T1+hGcNU9LR+
 yW0tCE0fBcAiAU7JhagPK83ZqXlqC8SWlEQxnNBnfZvzFTQ9kggJLz187iPLEKPemkIx
 4aVjsI28Lw+GSoG+zOuL4fhXEAlFLDnIb+KRT3DVH5RdNvOB1LENBhVX5YSrq8GWh5wq
 odgg==
X-Gm-Message-State: AFuF++n0b4BteZHwo9CnHm8b6iIGKKebQFLGcfz47NW8gkc90qiCwu4q
 Pt2q1eCwXceU3IeeInPgkbAnMc6p1LdSYXemkV/icDj3Sj5hhbzbnn0O
X-Gm-Gg: AR+sD11qf0y0xZssTJrbthd4OesxFO6aF9P2BnvGZyWCozfjBQ3wVoLLKT0l5toGtmG
 6mU6ktWDF4kA3xFnzfgRWHDV4JFMkKH4JmLryoizGWyneRl4GoEUop8SrxRK7zxSqgsZOiVQk7b
 X+Pdfy1/avk/N2/seooR/d09r6n+Y1COmHNFxnZK+5SRZv6DEUXy2QvOtsRlongCFplnIwyOylb
 xvW5LFbYFb4+pckkicbxj3fA4nxY3mZErmmxKgbqP97tGdLfA8VHnyl9QaKq3dHe9wvuEIHPLSu
 rvpWcACFcHBrkZ+MO9tsP/6psAaAu3Op5NGUXz2Nk61sToi6659G4KYIUGCf2QHJR8HLkk3VZvr
 lX6lD8iRajUBsKdj1u0B3EcPzqaeQnrIFjU2j8mhfv//LavSBW3HXhIIouwwbrz7+Mc3AOPytF2
 47uwbCtcbTSO33geNaetYHLJ/7y/rd7SmdT5eXBF3bVkPUiVfzVCa+TAi+iEG/GA==
X-Received: by 2002:a05:6a21:3e0b:b0:3d8:e57a:5a5b with SMTP id
 adf61e73a8af0-3d8e57a5d2fmr563791637.5.1788258086185; 
 Tue, 01 Sep 2026 03:21:26 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36dc602sm5470174a12.24.2026.09.01.03.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:21:25 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:51:23 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: trini@konsulko.com, sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] bootstage: fix record name fix-up offset in
 bootstage_unstash()
Message-ID: <7guo2gscv64pjcfcp7wjvs2r6msrxgylgtpcurbcfpd73siplj@zc363ld34pb5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The records read from the stash are copied to data->record +
data->rec_count, but the loop that assigns their name pointers iterated
starting at data->record + data->next_id. These offsets only coincide
when both are zero; with a non-zero next_id (e.g. after a 'first' init,
where next_id is BOOTSTAGE_ID_USER) the names are written into the wrong
records or past the end of the array.

Iterate from data->record + data->rec_count so the name fix-up matches
the records that were actually copied.

Fixes: 03ecac31498 ("bootstage: Use rec_count as the array index")
Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 common/bootstage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 4532100acea..f3f4f7b66e4 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -478,7 +478,7 @@ int bootstage_unstash(const void *base, int size)
 
 	/* Read the name strings */
 	ptr += rec_size;
-	for (rec = data->record + data->next_id, i = 0; i < hdr->count;
+	for (rec = data->record + data->rec_count, i = 0; i < hdr->count;
 	     i++, rec++) {
 		rec->name = ptr;
 		if (xpl_phase() == PHASE_SPL)
-- 
2.43.0

