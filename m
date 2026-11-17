Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3B606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yuWefAJ9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vq+w42J6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 704438119E;
	Tue, 17 Nov 2026 15:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtlgTnczhuTG; Tue, 17 Nov 2026 15:04:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD1BB811B7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927860;
	b=FLQRSblEq5Vkwr9SZiB8zPf0eYGqdSPsjMUbpbfmb7ldsf5bZydYO44+sSgbR7ZVLlXD
	 lKDjs05CqrH7gt5c9NznSIYvOMkTSItJUMRtnnbHPMeSmjiWTzqnRxQH3EpgSpfzWgAos
	 VbGavBwVsTaLtnye2n4dHVkFoMgz9Gtv7Yq9Y6pcPPk/WLhoXPObRifDTEeywdaP1mVWh
	 G36yr7vEXnjwrAWnq6WtwVoDYl3cKV9UQODMcY2v++foTPwiBIlY8MN1S+Zq5Q02/cf5e
	 b8qUKAEIe87YMFomRjXq6VZtrApaKB2xZVqFZwrnLuekAg/RRODucPBVWaQDWKPFQkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JI5Tii3ZEZN1mEypfmktQLnpQs/ryFN4/a0eJ/kqd+0=;
	b=ZTdFvQb1gRpjrYGizT9LVofzVpUrN5GiGfCEKPLwGLTb1UFM6PJHfDWBgIOOCq41twDl
	 r0p+j15tJ4MpOe3+2mBegc8ErJC1hG7m9GO2TAU82QKkChbn6Wxte3xdwY8fElAg7g0KB
	 TfzKPL5mD8A+CkKm3CdG2Rz1ozFwEJT2xdxPIWHzXlv3o7iHw9hBMWN59JhiThh3R0cCy
	 TVxOlWt/dr66Re5bSDh5ivKIa2dg7T0x+Z293cWag0FNKXRYt3YOAfy+Y/JLWnqSrfQ2y
	 TJgzd6is6/wnOqW4aN76pAH3pIvqi6/NY2b5pGstOwnnzExMHsVkGo+rZMp7I1YCoSg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vq+w42J6;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927860;
	bh=JI5Tii3ZEZN1mEypfmktQLnpQs/ryFN4/a0eJ/kqd+0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuWefAJ98pY6P7aTyD6pw5f/0aRVCkzGfNCeCiTNS85GLFSsHrEyfn9ztsTLPP4ZS
	 M0fedzwCKqriVKPVtehCTfk2gv9JILJtUoIBeVy7mvyLtuqhI6E1rbWXgJPLtYFmED
	 /VrTc+qvzFG3L3wg/59ihcU92xgodpwVz5LDrao3+NzsK6I8yEty8h79Nx/rpH72v2
	 h6YvbCBpZjzMVwdi6EvsX3bVnRbHF3z1HzSId0w2pF4HPw01YFv07nJQctg3k1CH4x
	 DOZg0HU0dybw9T8OECefoLZqd++0207jGp5xaFvfUq+iO+O82p9rPDAa0K9Cohe5nR
	 Y8nq+dXAZaWFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD1BB811B7;
	Tue, 17 Nov 2026 15:04:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9C9D1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FEDF81177
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQAHfv6eUln2 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8ECE8116D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vq+w42J6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8ECE8116D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EBA263533;
 Tue, 17 Nov 2026 15:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50BB1F000C4;
 Tue, 17 Nov 2026 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927851;
 bh=JI5Tii3ZEZN1mEypfmktQLnpQs/ryFN4/a0eJ/kqd+0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=Vq+w42J6j2mWOPqs0CPqMn9q5xf/h0sNdE1FwGE0Jcd4u+8fanUhgQgXGdEyLf7VC
 3iWXCxGFXtUEMyjbibOvneWHUpij8LTF8NnMkEstoSh1B1vj84fWLaVvV0dizk6m+b
 Af0wLw4IpNOphotXEZh4PiH6bzPsVoly+yGhEI/4ETeGz4g2zxQ7Zqg0VqJw6uZbfI
 Y49VLND1J5GvH9b1GrV97QdHRa5IYdBVUFmdZs06u34OEg04H+YBWMdypTsVbaB/95
 CA/U8l85lCFHywVnqUpG7LX+tzGMl69hORNrDNlAqU7IU8H+XivH4qnODpGpuzBLqf
 c9nejT7b5FOTw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] usb: gadget: composite: bound ep0 requests to the
 request buffer
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <3f4477b0-1aa7-47f8-97e6-3391dce81d94@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3f4477b0-1aa7-47f8-97e6-3391dce81d94@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784365.252888.8046542995168458123.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=dxk4L7OBKUv06lhT9uopegm+qlP+zpk3a2j8KitDNiI=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Gzn/fTZITz8qOZfW/8mvU5uWOoQlHjV+bf70
 gMgCXUcxPyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs5wAKCRAZDR20Zk4Z
 NUNGB/0XJPtGNEdjGRKSOCy4w9KpDVhJYgMEQYVJ5ZJCSIRNXzfeWbuT7cfPbLjo3f29DHxOe1J
 dr1MpMEkW66G6EsdgGB3MavCo38kH8Z78gv7bISYwOO5Oqesyu7bPlu2XDrJgeJi8nB2F4VVHIe
 tguZwapGSyNbRhc255F3AVNrvwtYtxGlx85HaTQ9PEuSgysQ4Rrc3hppeMjEEQta7XXPqmfrRyM
 FSLdHLoUKySGvgI4B2+II4HiwNP8laF0r28MLCN3j8IK4RIujnt3utSGRRSmwqfW1795z+WIF87
 Pec0arAVdEA3HwQWUwEp5zXrlIGuMnrwQfe7wFoHf+Gfn68t
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

Thank you for the patch.

> composite_setup() hands every control request's wLength on, unchecked,
> as the data stage length, while the ep0 request it queues, cdev->req,
> has a buffer of USB_BUFSIZ (4096) bytes. Two handlers take that length
> as it comes: the OS descriptor vendor request clears and returns
> wLength bytes of that buffer, and the SDP function's report 2
> SET_REPORT queues wLength bytes into it. A host sending a longer
> wLength has the data stage run past the end of the buffer.
> 
> Linux closed this for all of its composite functions in one place,
> commit 36dfdf11af49 ("USB: gadget: detect too-big endpoint 0
> requests"), and barebox carries the same check: stall an OUT request

I've searched for the mentioned commit sha in the linux (36dfdf11af49)
git history:

$ git show 36dfdf11af49
fatal: ambiguous argument '36dfdf11af49': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

This is on master (commit 666539eecdf4 ("Merge tag 'assoc-array-fixes-v2'"))

Looking a bit more, I've found the mentioned one but it has a different
sha:

commit 153a2d7e3350 ("USB: gadget: detect too-big endpoint 0 requests")

Can we please update the commit message?

The change looks good.

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
