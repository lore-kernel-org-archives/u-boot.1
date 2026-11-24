Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD0606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s7aYFkmU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=A+8MZpPS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE7876067D;
	Tue, 24 Nov 2026 00:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkKNSG2xcFfs; Tue, 24 Nov 2026 00:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D4FC606A3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795481479;
	b=GN4/QueM1+9O7bb8DecKua/9Ey0PfqQC71io/TW1zpicJ56rcyRWKCX0iYxSRs6Gg+Yv
	 fQ7eX6Q7nyomMiWsQRBIZn/vhkueWDjp9Ot9QAu8jXuxBImnrbXpWoFq20Ygm9DDnAbln
	 RKGBjwcLd4AtCb+w06UbyEXnXjdV8KJTqh5fO97PBx2M0Py9VBawy65frDVO8G4rJP0gN
	 1P1yJ1fAphIOC6ERcKqQ3mrThvC0Vh5xODi00jDmCdGZf76Uvy2orb7GERqiKZoRt7KOJ
	 tOwYpWgEopk1q1afje1jHpU1upn0Y5R46nIG9mTjkEYhkuZozh6ho/ACVr3QxvYNYqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795481479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mxT05VqyukIDokXGm8VYfF89ihF/CJ0MjOJ9YBKhDRU=;
	b=UwLf8iqINAinrIl58ryVsiciGkUlJ2kbN6qcs2qKf/mb1dGdtersJDIBXKuWSnVo8hKv
	 P77auPix2/tJ5CdWUX+OHpLuDXQm97zBrYlVi5+Qem3V0wdhZAeSzcfbyCzzrwowEkyG1
	 Ia8zC1i0FMlmHQ2ZL93AXgMkKAAk7tG7Nzv+j7KtpgxPh4kLk+ZIbtJb2aXHv/37qbj+1
	 a2Eve4udW5yLlzLCYKBg1oPgD7VkQRYf8XDOmiCIftJYMpLx8zyuqp6ymn7mZKih8GM/A
	 IiZMoa/3sM25M7VJ7fGW8uPr2foeuaX5atfA9TPHBBNz3jFl9WOn52heUluEl3EH6pQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795481479;
	bh=mxT05VqyukIDokXGm8VYfF89ihF/CJ0MjOJ9YBKhDRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s7aYFkmUzQMCmsYw4fOlhGTPq8+WIlSru0ji1Wbh9S+Dm3G2QBioysb0NyIzgIJbb
	 5V8QtBEAK5tQqmXcKo12jB3Sgf440BHNWS3GxcBINdyGDP0eHMZDVFWHFGnqqy3J2g
	 G4ninLFE6uzmi/uLG0ClJ0TUKkO40BNYL4ayr4ianWnbeK7HLWICpf2MnJ4HbXHXtB
	 wklCRlpyiH2rn+/Mm1j491Rg7DKNYJmHp3AYcn7jlNti8z5UGTtuebyXLJwHAoJzjO
	 7ndeQCFil0QYDoYw1WDwXI7Eeqlafp+eV0/uc+fvibHhl1bYxVMB3WijJYfdgJtB13
	 ftCJhZyJlUA/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D4FC606A3;
	Tue, 24 Nov 2026 00:51:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C735FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 00:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 664064007E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 00:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oQlxcwPhHf2U for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 00:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8FF9940068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=A+8MZpPS
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8FF9940068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 00:51:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=A+8MZpPSwWuEItjTMNssZYsq+5qq6JZC75j7Xg9+M15Q44pFZjZl1AZHCBcqPypAZJONGrzRXmwiLmYBaSAB3p6zFv7/zTHxbs/NlOUsfbkQd2YFBwShP3bLV49X7OQU3f34jxnyZbaHL8+Y960Wqcyf2/rHSg6pedoSwkIKTik=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=mxT05VqyukIDokXGm8VYfF89ihF/CJ0MjOJ9YBKhDRU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795481451939592.8120667281482;
 Tue, 24 Nov 2026 01:50:51 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Sean Anderson <sanderson@brivo.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Nick Xie <nick@khadas.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] mmc: meson: Parse devicetree properties
Date: Tue, 24 Nov 2026 02:50:00 +0200
Message-ID: <20261124-re-sean-meson-fmax-1@iav.lv>
In-Reply-To: <20260824132518.522252-1-sanderson@brivo.com>
References: <20260824132518.522252-1-sanderson@brivo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sean,

With this patch max-frequency from the DT overrides the 40 MHz cap from
8fa0db145f6 ("mmc: meson_gx_mmc: reduce maximum frequency"). 47 arm64
Amlogic DTs set max-frequency above 40 MHz, so their eMMC now runs HS52
at 52 MHz and SD at 50 MHz.

Neil, could the v2027.01 release notes mention this, so a board that
needs the old cap knows to set max-frequency in its -u-boot.dtsi?

--
Igor Velkov
