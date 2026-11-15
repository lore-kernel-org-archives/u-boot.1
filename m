Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5F606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qOPtpkdW;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KKd28Jew
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B5C4605D2;
	Sun, 15 Nov 2026 19:00:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHNgz9tQP62C; Sun, 15 Nov 2026 19:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 714A16067A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769235;
	b=C7nnRlNZRJPRY/Sh4sdfDR5ks48wt8WRV1Rs+oCIQueNjNc+jJFDoZ1I6d5n82ITm6F3
	 5mmfhFvldLQfTF98OJhA9eswd/o8350WkDudQ+K+czgWDikOKi0eRGWWRRlq3djj28ukA
	 +qiHmc7rbNmajaGr1wIBBs/JFFUuEjcH9gbXbWPFVXUE6RsSSS4qIwU5vFO4ci0FGDk64
	 h0j2Hmt7JzNco9axBtkvKo+kOCB847RgCp07LeLh7eHBbNXBCx/WaT28j8ppM8XuWM3lZ
	 yNs8iGA7a4Pl2QculjOgRU1k9qv3N9fVUKjWK0kj+i+5Q8JepvMEY1VA5NkSrekJrsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rjxyHK4O/oZn+a/am4cwYA24fpVGFfWBKMuMyXMhNsQ=;
	b=Vr283MUkz9b/BLpCqwHZPGUQA8/I1PWETroVlcGXvihLVy7y4kyM29G0vzpxoCfx2SQC
	 Kg0I/+HcPXnkvIPo3YEVYDdGSpzlgWed6fhAW6v9jMQAp0qOXjkziycAzMvqpdlgTwDDK
	 fXAoyRtUJuTviIs/gJ3Rx6sMtEfPHlgcHYjkGmNwCNLURg3POENl4klrOOWW0fc+YwUZM
	 PfJb8a07x3G6YDSmRmtI/9vqVEn8KqObRMWrmk4lPjj2iRIV8sN5H6EEYgPmtdO0yHNlq
	 NIrPUy1pIKpXwCS0EkYnQpT73+QHACAdJB6Xwi0P+JLQS4D7lQDeh9z3idxiq6ujGbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769235;
	bh=rjxyHK4O/oZn+a/am4cwYA24fpVGFfWBKMuMyXMhNsQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qOPtpkdWkF98eeauXSFmnqMlUHG++TCOUOUBXHdh+VS5+xYNKBHADfAPHFVgzFY4q
	 3aChQ2gDJExXKifQtu06ppB6Hi6K8TuJColtETMFDYNVOS9KnO7FQphmj0AIHz+DH0
	 izsDrIz9LNjCfpcb10D90ROxB49maPgAMLZZzuUHLEJhlvfsXI+X3r0/Ce7wd3YgdJ
	 vB3lt8AOd0qpuJQCe6ioGp5ypr0FuWJEFw0FDXp1gpJu4Qpjj9QBrKYCSMGGOulKuG
	 Li0wLR3enQOAMkwB6QtQ3JdALFgT7cY5MUqlcCxikNSz5HNtFkH2E3RW3UIqSWRXAu
	 U4VX7TPH0uBkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 714A16067A;
	Sun, 15 Nov 2026 19:00:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21C37109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1095F80EE8
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1Hqbcl2wrld for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B897D80ED9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2a; helo=mail-vk1-xa2a.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=KKd28Jew
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B897D80ED9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:08 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5eaaa9b1591so3316793e0c.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762727; x=1795367527;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjxyHK4O/oZn+a/am4cwYA24fpVGFfWBKMuMyXMhNsQ=;
 b=KKd28Jewtg8zEWz02fNnl5i3f8gNz5T4uvFZCYrkWs8HqiKVMIlnxZkZ6pJdjPTrv4
 R3T71Dl56Q6DlT01ec+CQa7JCYFilZOg2BgltzA8mhCHLdzgY9js8Dq1f4dCoRrOoOwK
 DFlk/KAsYAl8drNXuRIih37qrsGaMMYnULw+Qvcj6/qvzHCOfXDDHTLUD7JpoEK2mykp
 erfq8hDG5r2Zx2dIa9hE/MoL1MfhFQuYjvaPQHL61YfogNVlrmgQMdVumGJ91/ev4GTu
 7xm2VJO2nBHWySWjmnqSBvWcFmCxw6ytIoftpr58HTodvs/Jhm3LKizAKgwkk2ndG8ss
 EW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762727; x=1795367527;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rjxyHK4O/oZn+a/am4cwYA24fpVGFfWBKMuMyXMhNsQ=;
 b=j8y+t+cOk9U5Ln2ZS1uTS5zZN73M7lNk15OAIl/JNweJVkXpAOK+VwoKR/1qCRVkkg
 ptk+rBuqC8BizImfaJ6rRqmeZg339ntidgtJx08NzUdHOLFLGoS7Dyb1bjknNixUJJCG
 e881hYAfCTsRI0JZwmsLqoQ4b21G1kTrYPNFrmQ/c0hAjtx2Iw/eA8AAI1buuU0tJp38
 IOS//pkAS9TF6CaMFl/xG2tqjdmXnse3cDsDF/gkJiEsHBfNsxZGoHOykMmVmcYEMdIn
 m4AkOKaPNXkgVVXwtiO+aVK5nL8TJCh+wuwFD6sRmU39uW/ONtIICd3xji8NBefyHMZf
 KRpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEbUs+d21/LueFb/IxLPxpOF+XelxCVsH6KBA28BYFERBKmRm+UA4ETz+hclBvEYmlS8QI4Sg4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/L829pESkTHLsyS2Op4LYIUIjx8YdpMCPdOHKI49x6i7Fd5QkB
 +HGL8g9cWnRFnIGVtsIIXgSKRDLvzRurVSwv58UceAaI5vXnnbwr6Hd0EOJrKv2cC/rxI/K4Mdi
 SFOsxdZzVedTzZw9hwHbBk3jIHbodanlgAfmNb3Xd
X-Gm-Gg: AYBFou19WdutIaoG/xYeRcQgyCTm+ERTECtUE6Obmn2o6yNf6KNiJn5PRrQeP+eDNJf
 /0szLPpm/BWQUjqi1ANOv4FOtC+J8zYZrPz6NHnh++CJkCHrfGQFDQ4gbXoQuwzHKVmsJmRSE+3
 XRuyAWGXoeev9D1oYHf+FepAivKSE7qfkRD+CxZ46v+3yENWLOMiuwoAli6wxZucffAhs08cZCA
 rfckuJ46FnlvnQkuF9EerF0HCxm/8SHppA+3pN8/fwELAcqMABG42hrjnuRl4LHBeH8rUAKrXco
 YMqQcHaUAA7rTq1q+EbwsekSWcVTn3QAMwji7QHO5ysIQpyYjt/f6Pq3eiew3uwvF3ALc6belQ6
 slEXQ45Hx4ZzgKffdY5fstL+2R/dsBXUDDGQrTmSiPHaFSThWrkebAoJ8gHrEMlD5rZybfgVQCj
 814IxTYH2VFm8=
X-Received: by 2002:a05:6102:2c8d:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d64d6e9975mr2888418137.11.1794762726290; Sun, 15 Nov 2026
 09:12:06 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:05 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:05 -0800
X-Gm-Features: AclHuK-_0Hb51qMaGwo4WF-izwH1mDrXzpNtp-WHjzktuXOjIAG9pz2KVljYReM
Message-ID: <CAOTQ16Lwp8m_tDTbiuT_CAVj-YByNJ2o5g_XBHwBNke+tuGQZA@mail.gmail.com>
Subject: [PATCH] scripts: checkpatch: prevent shell injection in SPDX check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

is_SPDX_License_valid() interpolates the untrusted SPDX license line
extracted from a patch directly into shell backticks, allowing crafted
SPDX-License-Identifier lines containing shell metacharacters to run
arbitrary commands when checkpatch.pl inspects a patch.

Reject SPDX lines containing control characters or shell metacharacters
up front (even when python3 or spdxcheck.py is unavailable), and
replace the backtick shell pipeline with a direct fork/exec of python3
scripts/spdxcheck.py over an anonymous pipe with SIGPIPE ignored so no
shell is spawned and early child exits cannot terminate checkpatch.pl.

Fixes: c261fef51ca0 ("checkpatch.pl: update from Linux kernel v5.4-rc3")
Signed-off-by: George Kola <georgekola@google.com>
---
 scripts/checkpatch.pl | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7e4d6cd227..d377c19a06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1168,11 +1168,33 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;

+	return 0 if ($license =~ /[\x00-\x1f;$|&\x60\\]/);
 	return 1 if (!$tree || which("python3") eq "" || !(-x
"$root/scripts/spdxcheck.py") || !(-e "$gitroot"));

 	my $root_path = abs_path($root);
-	my $status = `cd "$root_path"; echo "$license" | scripts/spdxcheck.py -`;
-	return 0 if ($status ne "");
+	pipe(my $in_r, my $in_w) or return 1;
+	my $pid = open(my $spdx_out, "-|");
+	if (!defined($pid)) {
+		close($in_r);
+		close($in_w);
+		return 1;
+	}
+	if ($pid == 0) {
+		close($in_w);
+		open(STDIN, "<&", $in_r) or POSIX::_exit(1);
+		close($in_r);
+		chdir($root_path) or POSIX::_exit(1);
+		exec("python3", "scripts/spdxcheck.py", "-") or POSIX::_exit(1);
+	}
+	close($in_r);
+	{
+		local $SIG{PIPE} = 'IGNORE';
+		print $in_w "$license\n";
+		close($in_w);
+	}
+	my $status = do { local $/; <$spdx_out> };
+	close($spdx_out);
+	return 0 if (defined($status) && $status ne "");
 	return 1;
 }

-- 
2.56.0.611.g1030f0b940-goog
