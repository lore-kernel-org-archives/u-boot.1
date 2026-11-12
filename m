Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA27606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gs5tiRVi;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WwQG8ABu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C019381852;
	Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSKyfhtiw5RZ; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2357E81871
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794520566;
	b=MTu3hIyIfSMhGiogQMB3/3CG3RKRsDub4OIKWGzTY513+FYUiWEZAzW7xwFVyUZqTnLK
	 IVbTPvScfQfkfenyCX9SsCiTt7jKaiw/09tKzxpWfWnM55iESuGyXE/CI5tEvS8dtE5Lf
	 pgUsOn09fvVhka9CFw8ZoyyRH8eV42PnoO1Z/YRfAH2BdqM7/W+xQU7wG8Qi/xE++AWtS
	 y16zz8twlMJZWgY2LkS2rJ8LcLVeuVDa7A5JCMU/URG9T8jN3hngpLKMYFLIUK/e/E6gB
	 dOR5jtnppFBmMMUvXkbqU0Ou+gHdNkvS385CkkGUccWOp2n6fKSpZPablocp3BqdHFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794520566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MF7Sg+O11uP8eJCNykr4yQSgj/NNzi8mj37CduYHomI=;
	b=ovV0Cw/CvYJpsY+4WD+F1GZa1z2VUs29wc4UUopzypwOxbvc5ZTtYcVqODz3F+hzqavb
	 08smYHtSkMEMPW29K5aiMYb7iv4wKP/gWuWVsd7UL3Mo+Wzecmns4e+UCLTpxpBTHObX/
	 q6yZxkscqNOad9bzhGHB+9xSzO+RfMY8lkGgFw06oOYD6nT6EoDVNMLLvS/pj8a3J0ar7
	 0bsrsOfHWJ4XNYXkBl6gxHsXah707sP26pmcW+pOOxAfSwfZvpu53wemqvUqyuaaEI2uC
	 3dFFvv7IhfyW6qKnylLMB9zmFlH7jm9V2pofiE/Plkc8jUFnRPVcpNtgDNDb+EwZO5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794520566;
	bh=MF7Sg+O11uP8eJCNykr4yQSgj/NNzi8mj37CduYHomI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gs5tiRVi9wbpIxxHCxKVAJYZ+IWEThyICrKs0QIB0RUUJvIVrDtxMyCe+jcJDcyaE
	 iPZhJ4bAT3WOxmjtdUA6q6G3zqB3vLyWTm2uHNSNZ7NRq11ZVX0lHdCb0BPM6M1+Nn
	 WdTQFa+am3qj5a6N1fEI/UgzAI879rt7ubL/OuxyvuWyLyx9GGnXfNB2XdcXASCFuT
	 32ttYfIT0R3j5GKR+Nblx0Hh6d/AikYUspDAKW1f2gNQ++FfX4ivm42dO9c5f0VKGR
	 TwL4XCgw4CZriWT+q7DVkp7A0TuI/rWTXGD751cdDaf/CtY5wn7CCPaDzyjRwdxbX0
	 vBdbyPwAqi1EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2357E81871;
	Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F61AF46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 252F8405AA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8aa3jYW5H25 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:56:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 237B340DBE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WwQG8ABu
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 237B340DBE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:03 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-54f873cbe2aso4159941cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794520562; x=1795125362;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MF7Sg+O11uP8eJCNykr4yQSgj/NNzi8mj37CduYHomI=;
 b=WwQG8ABuVAKcIvtT+0S0dgx/8oKGuOLURFwNFp2jVdlR4KU/PV705bQhfVFjmIr2b3
 NnaovLeGtZK/kXhrvZweekKlIXl21FpGOrz9EEuyo64SgB+VxWedtKli3OcnvDDEO1iU
 hPTIY6RHVz4rled+GT0ld53iIwHVxECMnuXuKwws9sNLKlghKyTFpXLmi06PomiV8o6L
 QrANIiQkrysnqHNMheUcfrtrlsyWPa7bW3riVx2kwMbM4jTM0nJbMlIm0Mh0g6vJUWsx
 ZP3BpcKIjYeraqJJY6yKbdC/8yEwYpquDYuODFl6wtyqKD4Re3VUx1gyzrsHNUGs+aDS
 rRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520562; x=1795125362;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MF7Sg+O11uP8eJCNykr4yQSgj/NNzi8mj37CduYHomI=;
 b=kGm37C8eJLpGfpeARD/76wvC2W7Wl5OEjVbv9rcfAzZGZpSzeHJwIh0/BAYBhT2oeC
 VfWCdmy17sMURkay82wqyYCJEuT7VKixKl9aECMqJAdCCTGy26eGZ/Pz7Z17/5PFKdK3
 FhKVxHaVCAnt0g0M5pKlx2iladmpW/arlROcKr+m8b6h2hQziJ0xRY47ikhX+lp+Ax95
 jtWiGyg9Ng2DSf8YpDgE6cNKUWMHS5TXdKguNTm7tBnhGiM71p2p1vH69NfKrQ1URfR1
 1rhq+dTraSIrwfaiGgPgawEhv8dLoVYME25ZX8y7TdJ4egCzc8dBHRkypp9gM07zueu7
 o48A==
X-Gm-Message-State: APuU4Z/VhdYV25VVwE9KxYZ5kZDoWjdZFRqGwgAX/C+wMYTuznYvYBln
 DlECR39SjK8E4fnbADGkSyLSpOqAJ033sySallwvcUrLi4sOY+AL3dSo/NhP6y3zgHqIYiA42pa
 ySWSnFOg=
X-Gm-Gg: AYBFou3dp7oMq/xadeVVYh8m5GDUEUOpoLfKuPMA2zouRYvdmExXFQO97n1bndc7a1r
 9rpU/3bh08ScM6tz21E86I2b0RC7HPUvoJAf0jJZpEh5pkB0QQGLuYb9+PVHth+Mi/7G4oPTu/H
 JW5nXJJltliGDonIxgGAuoOtxRpAUpxYzel9h7/7roo+BYMyRcanTHXuO8CkaNP7XcHTR0GjneG
 iJ+g95UC+VTQcf2pyNlRvY0anPoSpRqBOJwkCM9uuHyMEN10ksoTh3dsW7rTqJHgtmxs0Gf2BY9
 07UAv+4m0JzanxJKa8Ucva2m3jf8E0LGxaXDH939mb8fo1MHdxrwAncqx/FaO9h5w0eA7XAvoVL
 x081GRDN/guRwnrB7KKLmb9amrbB8+YMwthQryOBu/VC1yV1TXeclNEMaU+Uf1Kl2tRBlj/QJrZ
 HtEBeOqI1ryanliTNIUAzgpJqWnPzXf9KrXC8YB9roog/hpn6lhM4UV3T+LhJBg5jeX+cgF+FmC
 BmzDleoHSpi8Wvvb2w52r4F8XF9Ulk2C75jHudX4Av0SClBRHiPPTlUs1/lL9Wj0T97vnevKOb+
 iKAXNq3xHM7Spju/nRqQO+N9QQc4GfAgE6O4PJ/zSWOjRBVMjkAKtKE+3LsspC464Yo9uRecHrj
 G/60ZJy3cXREtLQ1kA1chMM3ci8py/ADuvevXA0QMNWM9QY7GRCiID4zI2kkx
X-Received: by 2002:a05:620a:4592:b0:93e:c12c:9dd2 with SMTP id
 af79cd13be357-9494bcca42fmr119781785a.82.1794520562270; 
 Thu, 12 Nov 2026 13:56:02 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d70489sm5661676d6.21.2026.11.12.13.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:56:01 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v4 0/2] doc: tips for submitting patch series
Date: Thu, 12 Nov 2026 16:55:45 -0500
Message-Id: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOE19moC/33NQQ7CIBQE0KsY1mKAIm1deQ/jgsKnxRhooBJN0
 7tL60KNjctJZt6MKEKwENFhM6IAyUbrXQ58u0Gqk64FbHXOiBEmKGEV1l7hCE5b1+JeDqqDiHU
 hueAGjKkrlJd9AGPvi3o6v3K8NRdQw0zNjc7GwYfHcpvo3Pv/kCimWIiGGNqwUmg4Xq2Twe98a
 NF8kdgboYSvIywjisiaGCMU4fUPUnwiYh0pMlIJI0tN95VS7AuZpukJ9+S7YFMBAAA=
X-Change-ID: 20261028-doc-sending-patches-d3a464feff98
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, E Shattow <e@freeshell.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1794520561; l=549;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=fl2FrX/iuJDG9xzd+Ms6SGT3MMNznRHPLH7DpiWGcgE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPqZoqNf9l4HLjvSVsUUpu2Zr5+HAuVhdFrEbut886pLEw1dsIlcmG3qKQmhYUqw1CJY+GVzAhC
 EMxKr/ObHsAs=
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--
Changes in v4:
- add second patch with minor update to CONTRIBUTE.rst

---
Ralph Siemsen (2):
      doc: develop/sending_patches: add tips for series
      doc: CONTRIBUTE: minor spelling and link

 doc/CONTRIBUTE.rst              |  4 +++-
 doc/develop/sending_patches.rst | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
---
base-commit: a38a1d2736eed7978df10f513a5f6df4075b2277
change-id: 20261028-doc-sending-patches-d3a464feff98

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

