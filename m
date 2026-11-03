Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E3606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sapk5soe;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=MVLINvow
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F647406B0;
	Tue,  3 Nov 2026 18:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5iQkkRugOLdG; Tue,  3 Nov 2026 18:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6466140652
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793731879;
	b=Zdtlu5Zd1qlj5YcUiGkYx3MVdzIoBeo3BvHsP/yGGLaMa4eKx1OFU09HixQ2MHi8GmGt
	 d6HLoThDKlB7bRy5SgnybU8vMAAdi0XltsApJTBigtk9q0erf4DxWvw0kPXQMsg+4lnTJ
	 zU+XteDi3g2epofjTf/hyjL5oyyqet9y0YQfhoJKZ/t65KfBIN9cGfHJU6ojzUbVbwGgT
	 hSi/MncLYG1de3WjzSo+YPeEPbmEEop2IfOtK8NO+Z09TNIN1iYCvgeltvjXQr9h2gCpm
	 mhV7Q67ZaXOxH8O6hNCm8f0QE39D3OWCLcQXHsgXrnPJxdPULDh1YdyuLMZmUYj55xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aTGpIuvDayV3HbggZPEsZ465fKfb/i9nJMdTyKEY6hk=;
	b=h2II01FNql4nN5nr9IkIRV+IeIPoTBc8P+bZ7B4lzmsph/S+OHqxfiHeNvH7F38yf1De
	 xO6HXeqO7HGqQweKT/jvDL+noz+PvXQMClg/d5yV0/JbahcbiEdqftQvCRLenLohiiTCz
	 pG8gcXuZMTqPRGe0Su3L+GQefPCi5LKcn7OgKYkPPPs26s/3gpwD0PmS+SAmKBYinCCjS
	 2Fl7/xj9QZ0vI4DSYywr9oWtuMjzWanaM2V6gVbq1YAnTpRky6KJA6XoF10Dezim3IiNb
	 eaBSMBSxo06Vm0crnMUCSySHECn3oMPw6p6RKNCzUratgr2YY6rB6CaKYE+epmRThnQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793731879;
	bh=aTGpIuvDayV3HbggZPEsZ465fKfb/i9nJMdTyKEY6hk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sapk5soeo6HHLGICsfj5vecNZeGALp54Dmb2Qpm5T751CcA2qzQkQXR2juRrvn8fd
	 Eg67KecI4FdetCtfWlUN+KauYhFCxztq44jJSqzQJzK1OC0uAZcn0juRu7bujGktH0
	 C4UL56C/Jbox97OCGyhrTa5hFQeXj1DCt1Qan4+taXFV6qMe1QDZeeZQxnTxCMJLOs
	 D1GrLIVsJVw+vvW851HxrgLagChf+YSaLHk6Svg7QyvPEZSgrKV+I6dkEBBvxxnEpN
	 siLEuETSlS8nPHTwXLuHdCpKzogIMLx90KT02G4HIUuBLGU/MbgnVc8PpeCTzlYx0L
	 rSUPrVXonBuFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6466140652;
	Tue,  3 Nov 2026 18:51:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27094235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18ED7606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dHMy7GRgdZa3 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 18:44:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7292E6067A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793731470;
 b=ZGOmtUuipWEQr8P5gkexPCTlpX2AO+YbxNvdeJlIkq/syiILslqiOyxREnTpHaJbzNN2
 SpI/b1qPqAxGHU/rw+IfAdYvGlypaiGGQ5rsqxiEu36S1ki+rqsXJ0x5bJKQDlPi+RXWT
 PCF07ANvSvc0Qw9AyHFnoSqyT9d9xNXGRVHUn3331Vgm6F62Swe8omQ1Vldr7E2kQAaFu
 RiGoWjfnXrvIWSefO86RFcGJvUNqszs7havvilC5zusSuCblYP/Q7RZ/BpQAhSjzu12vW
 /9NBXFobUYs0qtqPUaysx7eCwmDD/jR8tkTQ750JvJGtrbMLGDqQc3kOPc/Pj/a+0jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793731470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aTGpIuvDayV3HbggZPEsZ465fKfb/i9nJMdTyKEY6hk=;
 b=T63rExMHawf7b4xoQ6RqzRKrogRt6C/ChNl469xMIzgxjQZwKMXxsSWqOyoX2dsqGPLN
 CsTl/M+VaUS0v0Up0cKvC7fGRzFyH/Us1aRyV3wrCSSxcTCsIqldrVjHy+eoV9Zv93QLd
 7dwHPvJpo0ia5PUthFXj/iLRFkCmZSNDLaFg7nQzBNPwK6egPqry6Khf+iTYq+zbrFB5f
 Yn+IN4NDDhNgZsv/7r66FLJ3o50Eom3r0IUUhsAGecEEBQRaTLDrcOiYCrdcoQJ+3HzLY
 UXDklaksr0lrVMoFHvTF57I63ojMOI38a7tp4zC8tG5ehelfwryX/Wtjyh94Lx0/cYw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=t0.technology;
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b=MVLINvow; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=MVLINvow
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7292E6067A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 18:44:29 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cdaefe02d5dso2416663a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793731469; x=1794336269;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aTGpIuvDayV3HbggZPEsZ465fKfb/i9nJMdTyKEY6hk=;
 b=MVLINvowdsFhPhpW8PknVslOdG28AUskua5Ouxd8u1yeEUW75WH+Jh19Hh7bNzXISC
 T3d8PapVD27E3WwdFysSTO9tP48/IyJsQ4yf1q3nsYeCvwg1pwfPxncZ+Jo1VV+B9xvK
 yo5K20viB6XWC92AKB5+D4xtK7GTIj6lvbr8qjU5X+1RTuzkmLbaAe3YznrCOKg5TZQ5
 cmLM5Qdmba7LqYBePBbh49/jr+ofjvHrRUDUUG5CX7q4RYZwZJkI4yxgyj4oafTMiuL6
 dGayctJud/nCc5TL3MaW/lsJIxQEoNobFoX8fjG7OPJ16AAGOvgumkZ30BzFKXoqVtHk
 RwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731469; x=1794336269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aTGpIuvDayV3HbggZPEsZ465fKfb/i9nJMdTyKEY6hk=;
 b=I3ev4oMC9jCiRTirqQQLoEtr7JDujaXuEqNx0aegI86PbwU3o9FMj5z6LxsVazBozB
 1J5JuDISHMS49f5tDOzG05A1rzp/PQbA81+n4RTNg5eEaSVzmRdsXGF2Xq0WlGcvuE3I
 guUOojMlgv08WhWpbPmZV5q1Es/vyyC2thbtr5uidUKVLqyWJVm5ELmIho+JDISAIOpR
 +sYNwQVUovbath8RS5rxXnA3KIvMSCc6ZwrRqHlHSbQMo5Go/jaKh5cr/hs6qMQwB//f
 1aWbbefPutuIRqZJLyXDfV35vb9v64Ajo8EDTapUQ31mmuAM/e1crnlwx2vmIPkixoNZ
 cNyA==
X-Gm-Message-State: APuU4Z80qr2nmtbZtFcDtsU7oKmY/RYTKNpv+2Ka6PPuPwBzvWvBbYXK
 hEioiLcdfaTbUpLVegUXry//OygIS7g+mhlDwSQQ/3kJZCG7K6HntE0YjQvQqvJeXj4=
X-Gm-Gg: AYBFou0b16c67Zr5VHaWG26Sh3IaiTQmc65srSwZPhuUelwjwRWj37KTOHbpZzcL6xJ
 JqorEb8S7CnAxRzmw4CC89u64FYMdAhKVxllQJx0xYQOrXXJWDPtYvPq/XWhch+LLoHlvQKhiiN
 ECUgHlGH/nvMq6Iya44oQBQPLONOpNC72icUjC0XtWnKvmG5+gI9g0D6V0gEq89zvRVyO5HlOZ6
 Imfejh189M+oFXvBXJfdwM4oeeImb8IvMuRGNCDJ8LoBQDN7NlnUcpCVYikbsxH1u3Km2tSrgy/
 YEJZzzn/264+nrnyGRObT5BlQlOYZy4nUOSc61P17hHlcvbtUp/WNmwYQqh84omxpipuWwj5KLu
 rMwUCJP+4xOzQvHhXxYf334xi6ONdl+6BBkae+/V11PCFbF+SZiATae1E3YFG+JkVypRKhTmDEP
 QC/NCTg4GVpo0zUoBY34i1LUpzplwk+Av7bBmxYi6+j6l1Ja3kIzMKEb/WTWz0PhrO7Al3t4VvT
 ME7jOW4EObxY5fAIAWHc1swM7XgdFAdCPKWPebF2W/IOvOqLZyeWucUdJd9aBj4oOhS95FATXPd
 cMsI9fHVH+hKq7y+SpjUE8Np1hadaoQ1fcUm8nmivdDSDIFUn9BQgiZXSB8d4mlWchu3b0FBgg2
 y
X-Received: by 2002:a17:90b:4b02:b0:3ac:4291:f569 with SMTP id
 98e67ed59e1d1-3ae89574e29mr11982140a91.8.1793731469461; 
 Tue, 03 Nov 2026 10:44:29 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae880b1f71sm11496613a91.4.2026.11.03.10.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:44:29 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Tue, 03 Nov 2026 11:43:24 -0700
Subject: [PATCH v3 3/4] net: zynq_gem: free buffers in .remove
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-zynq-gem-remove-leak-v3-3-2f02ec0023f9@t0.technology>
References: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
In-Reply-To: <20261103-zynq-gem-remove-leak-v3-0-2f02ec0023f9@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731408; l=748;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=bDlxz3SmaQ+Lw1rONU2caZfEQMo0asvTj+8OmYZWlmQ=;
 b=YzxnND4PvMkx3YGjdfzau0neoWV474+ygKdwuwkBqT2fScYAWy0ibT27G0qXiPHSHu5c4OyFk
 3JiMwSwf/5DCI8iwO4ezcFumthD48zKLvVnQPIISlS/QjvZa6xsFuyk
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Tue, 03 Nov 2026 18:51:12 +0000
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

zynq_gem_remove() never frees priv->tx_bd (the buffer descriptor space)
or priv->rxbuffers, both allocated in zynq_gem_probe(), so each
remove/probe cycle leaks them. Free them.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index c15d2fc1318b42951648efe7ea67c6559589725a..8a009afda920ac51e648a2ac85e17a01b4d8b5b3 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -1074,6 +1074,8 @@ static int zynq_gem_remove(struct udevice *dev)
 		mdio_unregister(priv->bus);
 		mdio_free(priv->bus);
 	}
+	free(priv->tx_bd);
+	free(priv->rxbuffers);
 
 	return 0;
 }

-- 
2.47.3

