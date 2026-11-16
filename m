Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9693606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j+DVMcXO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CEC980FB1;
	Mon, 16 Nov 2026 13:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYZMnYsSyTYs; Mon, 16 Nov 2026 13:02:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F041780F34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834146;
	b=afKG3ZpG1HiwvNMB82+vgHknk+HwVH41tFpuihzx0KqWpbenGOz1JzeDddjHgIWh2IlG
	 9Uw82Eo4uiObs6QsWge8ZsU/fSbUpUiKBQ6wsGITWUpb1np1PHJAvas7nY7TxwQ6VkgZu
	 foLGdu2pyQOqGTeeXzFzvj/lNli/0wOHY6KUgVp1CK9RCmQwV/spiu0bFCe8uITGwAXVD
	 J52kt7uTR+SkfME0yBPagFKh0K9cZ67KhoV6iKwSkPUfo0wXDi9z6pLJm/VWJp5t0G1Wm
	 dK31Ijk2SWKEifExzbeS5GtORX5ZkRck5jECZxrEb5gIZDhJ/eBgUq0bWTUu9Q+9Hcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=seh3H3rNtW0YtuTwKgJN65uUp73qZscLRXmwvNmvJis=;
	b=OTgwJmmn4zREiAPDk5uV4qH0WPRycVrG1edG0IN0yUsGY3Fe3fTOvhO/w6epO5oSYYtQ
	 B2NXAs0cE1Q2oTKuaaaVlxUcKATKHZXF2TxTM68Twm8+91zumH8bbPKLW24/408R17BkG
	 kqbo9OwJNSjij6XWuDPvFROkL+o/n0lbGqfRZ+4swTOaVkspCPWyasd2OXaHX5uq0i7iS
	 geeSwidoaGkerCFPmjpeDDZWLHrx2TIwTvBrsTTVwevcTPqny0d1z+SO/KtmV+2iJDHLF
	 8VlhdMiAFnRFU6Is62K8IzwDL5reL3o4Imetsa87k29iRJs1opGKJTTBuxlKpL2pdoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=rustsbi.com;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834146;
	bh=seh3H3rNtW0YtuTwKgJN65uUp73qZscLRXmwvNmvJis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+DVMcXOPnpMCbKWYNqyA8ppkQ8tPvVm8DpiNZDjy+3XoPQMHBUDpCY7+FqsFIwka
	 2n5cksRMVysnwMF6y3r+lWlqGWkq6OrbDBp6xt1/wMVIl63S7t50McPEFGnvVLgEi7
	 DfBwcBenR9fPJi1GAaaB8LCmoVkMBmC19jbOyRjlads619FVfZeo2YVlb4XWv2D20G
	 xs0Lb+ivfNECmhVLXAveZUEIgPrnURHK6Cu5bOg0f3SchiMpx93imrJFPGE9xwqU+H
	 XrQ4iGVAxD2RnMOiA8V3P6FBsaiL4qj74ZRpq+F0doJpHQvownicsifjS7zZi+Ui1j
	 sj1T4obmKeDww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F041780F34;
	Mon, 16 Nov 2026 13:02:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 101784A0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED0F580DD1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJFg59TZaTxv for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A94080DCC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A94080DCC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:44:12 +0000 (UTC)
X-QQ-mid: esmtpsz20t1794807758t2df1fc69
X-QQ-Originating-IP: 8q2vpF/fXgZ8lOmnlxaOhf+o0O6el35pPCrcj9XyuFQ=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Nov 2026 13:42:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4081282890487324871
EX-QQ-RecipientCnt: 9
From: Zhouqi Jiang <luojia@rustsbi.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, sjg@chromium.org,
 alpernebiyasak@gmail.com, jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Date: Mon, 16 Nov 2026 13:42:33 +0800
Message-ID: <0E589B613DC4FA4B+20261116054232.1930964-2-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115171015.GT554944@bill-the-cat>
References: <20261115171015.GT554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NshvC2+mlzw3FUeltr2v9rh9FkFAZos7v5QS9aG00q6JiQhdU5hM0AaL
 +tmlGQfQEsCANciseCLL99CtZeo9K/NLA4Lbh+Z0AXwGwdzEeHpeLKd54JvQSVG/8fpzcQC
 66PT6BIJgH5gAcTQwDu86G6fIKAR58S+Z4wi1MrkeKRELu11BZ2ww9VXuyke0+rGDEhQkbF
 gXGQOUCN2NaWcq1J7YOFj5rW2xNH8cuMlfA4tSkqkQe2fHKReE8hZ1DsmSO9iHxt0SyaE0y
 DQtFMp+3FR3eAxFO0TfzyspQw/4ljBnoM+NbRGAdaAaTHpG9KMgRYwpoVu7gbW3sY/MosXt
 uz+kxSdL0iSYaUNmDoiBvVA3HdcmRYYUjRHSg1mApUBi+Ly+E3akM4w06sb/vaRRojZQ4Bq
 pSauVQaDxqAkMbpnKUlFn/GNliWixXNb6raP+Msza4rV0a4HwCmSF3mu9mPwDUU/RJzoUVa
 eWC1mrUTD0OVPOokVmIoJhmUU/FrWk1Oi8thpbgNDg9OusVBgaT1SMbVurZVUtQU1JumbEc
 kTdyBH8e57fhC1cahkJEWes4GKoRrkCuyNRdZ9Ehn2/XHNWf6zl681i33OuudzhNERpdvi5
 3FW4YGVl3RVaEFhw/4Bv0zxbaRS+or7C0LnxCO3DER1gGfTtI3y+D8q28vC5LnqiNqlo7Mz
 Ft5h8pa2hGEyNOukirVL7a2+tURjTcuIS3YmCZfEj/BdLIYGiHrQj8JDzRxA4H3KVf7EPOg
 0eDEt41YM0d1m2fWxJV9V69pbJ6b9dvhsKOdiZVEYGC/6NRCMabIXTjDgfSKdXav2jt/qqg
 ql6tRNE8mqdcgk7low4d0Vq5H4F3zCmLqZZMyBS5/YrfSfF1pR8AuMcysLLeRuT92pTRjd0
 oNFSnmhCbxVpzpuhseg/DMHBhu8GcANcvnFwdONcijYIkaK6XtP23Wh5V9hsuKrfj/GxRgi
 fZ4uoAElq7Xr07liDj/0I4urQGdL1ZqeuyjvxsC/z/2E0BCcTAXuQ8P3Q
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:02:15 +0000
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

Hi Tom,

Thanks. You are right: RustSBI and OpenSBI are interchangeable here because
RustSBI implements OpenSBI's FW_DYNAMIC handoff protocol. This reflects
ecosystem compatibility rather than a formal RISC-V standard for
inter-firmware handoff.

I initially considered merging the tags, but I now prefer to keep
SPL_OPENSBI and SPL_RUSTSBI separate while moving the shared handoff code into
a common path. This keeps firmware-specific details, such as scratch options,
explicit and leaves room for other SBI implementations.

If this matches your understanding, I'll prepare a v2 along these lines.

Best,
Zhouqi
