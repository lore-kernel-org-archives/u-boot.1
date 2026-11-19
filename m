Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD5606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HStLlxUK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D531D40A69;
	Thu, 19 Nov 2026 12:01:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZwJaU6wH58GI; Thu, 19 Nov 2026 12:01:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EC1F6406D6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795089714;
	b=mjqZPMv3VY/jp3zD1dpkMkcVRoO9Y0h7bMM11ilvTl9Dd+n7+GO8lOM0WLXsEW9+J7wf
	 jzr+6JKeoU6EaBdeucbJ9GmV0Bun7NI/sgHoOjk2yilr4LXK3y1D4bt8CriE+TkFDN53i
	 xhbb2CvNyP7q32uWpXhgNhw/XZBjCHXmp8ky0+BxgkVWaADENLY4IuwcCOtCuu39QddW1
	 xiGQEFijOdMj3q0W9nkNd+Mw9/fQPUj79z20hXJOMXopsbL03H1iuSYCP1mgq7O/Es6OJ
	 aix8QdzkWztLaU1Hq9r1UgvXXMnrkAM+k4Br5u8ja8jAThZxr17RS/7BQJFZbofL1mA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795089714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:
	 X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QqaT8whBAbbemAjCzqG4LzqTEIiFtr8nqg1zNzHh73k=;
	b=IXzRRVGdHKX1OCn2yKSoWPpewOPR1has/E9eYLge8Kmulq0tEDLmGnrH9EA5Ku67EsSw
	 bGDP54keu808FScXvu6Z7XBkKgE0Vc5eMsUGgq4k5aCfa6x9JuWJ9p3wUCQqCaWPNLWh5
	 rehQgJjueQa7Wzc8iPNSusIQ5Wv13eGFfJYgo4qkzVYwYQk+GjWPjnIPe1C2nsMBEKOsZ
	 56wpEzN0fCdiQ4XtUXSGlWjiPIjsV/9YV3tcxqWBQlyARaQy0QE+TP5C5zP0/QP8QzJ5p
	 NmmIKAc3Px3VudYIiC7fi39eYQAUDMMCFErlZFVcrWzxNM9dECNMG7iMxF4Vw4Oj+IQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795089714;
	bh=QqaT8whBAbbemAjCzqG4LzqTEIiFtr8nqg1zNzHh73k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HStLlxUKH509F28cqKEcJX9CD0wU6aEBTWmwrLXWsSoaGBzg15aB5gOnGxcfnaKOB
	 un9s7+qIn9n5yngTja92UzLWRo162X/22GtzHxVBMLxlw3KCspbkjQxbjGjnAaK5Nv
	 MMc5rdWx57chC9eeNu7M7ahixJOrHjdQeMS8cXYr0uHtr+pmAstd09dVVt4O8G9eP/
	 nSRV3Qfj3A7eS8O9EiVctTuYR20Z27BISrA5ivTK9JFcfmxrK/7tZfpMSqNysCgV64
	 eyRcSHQBr9jVLLTb3mI+EoyY0yOG++4MIaKucvi2Fk4XSDGt4gA2P0fcTorLlE1lgW
	 xa1ED87xoSvBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC1F6406D6;
	Thu, 19 Nov 2026 12:01:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E74AE260
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9CC540527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYpBKZEvSJp3 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5964404FC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=18.194.254.142
X-Greylist: delayed 9714 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Nov 2026 12:00:48 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.194.254.142;
 helo=smtpbgeu2.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5964404FC
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:00:45 +0000 (UTC)
X-QQ-mid: zesmtpgz4t1795089601tc5847f5a
X-QQ-Originating-IP: ACPkFr9j3L2RE3oCxI15ka/fKfbsr81FoqWXAB8p0g0=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 19:59:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13655552842107644753
EX-QQ-RecipientCnt: 9
From: Zhouqi Jiang <luojia@rustsbi.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, tim609@andestech.com,
 leo.liang@sifive.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Date: Thu, 19 Nov 2026 20:00:39 +0800
Message-ID: <A529EF9EAC548DDB+20261119120038.3129288-2-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <av7gh5SblUm5WYA1@pie>
References: <av7gh5SblUm5WYA1@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3uTjkO5QXGxZe1f8OKUX3AMDJCjMUMDSY/pjWYwgQW8yjhFmWVBN8ux
 7NPEBEf4Og3RzHPgZzCvd+YyUjA/+/c+xBArHVQ4yeEjtyE8aZw0iPAD7HMguTUH18tMoX6
 cmbVfMjFExSfsEmGNGJgCfrU96J9jYAGsGc02uuZGjO6+8nTSaRIzOobg68/HPUUoSlA82a
 ZhsCEnqb1ORvo7Fgg07B4kZ+635V8ZHuiQxwf5FVSmuryEYj4p3oieQnMaEAIJ4HgEgsGhS
 YiBT5Aq4ClhA89EnXW+Rt7U9OFwGnOR6tOB4AnsJ16VNgKkbsDdaW/Tu/P7V6e+kwdbGNne
 8Vrd7xh1N/6CQM8c6d933I5PZmdwPOscVaI2qdPGkB+URz0fwk2yUD7sjDmIzNyyhzyzZFz
 0QjIoNRidPFTEql4MtME+P1DBAI6wjrCFhHHLY/oWIK6X4olBqftkFozYqMWf4v0JtgVJQf
 q21Q3VyhRiE9RjUa0GfyDF2m1fHKFLjXJ2ZUoYPqVDNIVAyVnrRoVddaAGkXrB/qaHmjGLm
 TSzK1WOz9qlBQL8gkKoTaNC5cYzxkG3RezFSVBgXmDg8uSTS6R1CiZX+qmyU2KKo3erno3J
 0lLdW8hOZKr5wHitemyVrfTkkKA1gpR3lvS/DuOuArBEFDL9JDBx8Roih/h3U0t3hCArjwB
 mmxhKDGVKUvQ6KbJJgF0YIUrsAajQt8sIvYggc4qRlT1vYJvrgvtm+QjurKS5ZIfYWRmDUC
 z5E7AxhUQVrH4usKvt5FTko7ioYSX7W3DSgKXZJO1cMT6J5XH9PHXUA3pdsquf1Iy6ztjBp
 abC4xMte1ola8bc6SPbxB9WEKIEdnkZzAuEcsfYbwkpfe2Ssn8EP9LQdimBbmxbbYZP0j98
 EAmaiV0SgOj3mOiHyduTVmTjtMevRCKmksFsP7wpG/1eho3OtkngZpquBStxXLnnLGeiC2J
 Y1wDXSg+/r2XaWwp5SyUdp23nSgfzDsdHlP8C43gccmrFiwyE7zTazIKYdbYnr1x/NuGgMN
 jFgOITle1bXD71CRUYHOLBynl9hRDZjh7l96nxB5cbsK9kXD+tlMg2a56NcXU=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ziyao,

Thanks for following up.

> > Would that alias be
> > useful, or would you prefer using OPENSBI= for both?
>
> I prefer to keep using OPENSBI=.

Agreed. I've dropped the alias patch. Both OpenSBI and RustSBI use
OPENSBI= and the existing FW_DYNAMIC handoff.

> > 3. Document SBI firmware support and scratch options in the RISC-V
> >    architecture documentation and SPL Kconfig help.
>
> The documentation itself should probably not stay in SPL Kconfig help
> text. You could inform the reader to refer to something in doc/ instead.

doc/arch/riscv.rst now explains how to supply the SBI firmware and how
SPL passes the scratch options through the FW_DYNAMIC handoff.

> > Would carrying a firmware name for display be useful, or should
> > the existing labels remain as they are?
>
> I prefer to keep them as-is.

Agreed. v3 keeps the existing FIT descriptions and SPL debug messages.

I'll send v3 as a two-patch series, with the SBI_V02 help cleanup in the
first patch and the RISC-V documentation in the second.

Thanks,
Zhouqi
