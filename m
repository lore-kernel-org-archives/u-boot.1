Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845C606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1E5Tzk1t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhaxEHHY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E3A54063A;
	Tue, 27 Oct 2026 08:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iR-VeLOygBl4; Tue, 27 Oct 2026 08:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B689440636
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793090817;
	b=IRJUBgpKtx0Tp4N2iFb9f9sK+b/TYyO4XlRHsTq3d1VcLpSIYU8FgeSfrbw12Sd4HkCJ
	 xKYPxnwj8NT2+XuWBoAOxunw9O5HkMytKA1hEcdpifWmFpZ58WSn21lAzjRRKE8VgBYCP
	 CqF03eRV0W2AvyDQwASJcrPPkAKs46r91aFIFbE6ttQ6hARa1jfFSRfAdqRn9ds6tY538
	 GLn3UNCuzdkT34I+LaMWRyTn1uk17iCXSWATg11mED0B0yNK44F/lllgEnSFO598YkD38
	 TfkaGLexAYgcl83kmlE3JqL61uTEMIj3zQ82psgbs5QV1cWZjwTyq8z5uGPXK8DPC2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793090817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZueCi67qHQ6H/avm/97LlmfUq4DN704TDAgJLt8cdqU=;
	b=HDT1jyP5jcSw4L9V+dvooCfVQWdvc94Apmm+MpBnuVPrHHfxLIv+Hgq9JzS3F2y2l50U
	 YNGr2WIIxVXIkvqg3BMRJABHYnNdlYysAQvpZZJe159yfTrtiwJSndpzSlAeCf024Ctdu
	 nRB99eOkLSwZInt+42ka3TDqdj3eYPhuam60WJdnNyOrD+HxlrTsDtairaohuffj+aqUe
	 gGIyj3IVWwmYADBeIH/+gCHVgRpgFTLEPwm5t3grvxrVRsVZQoXOPtwkkuhCnyzW7CwkQ
	 1g8exf9ssTRz9qc8/8Rvu2qCuZyxWeqMl3KDXwtahT9HSqkLRSoMNtYMTf6vq5U35YA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793090817;
	bh=ZueCi67qHQ6H/avm/97LlmfUq4DN704TDAgJLt8cdqU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1E5Tzk1tJTj0woP7cPVvWR79ApZI8618eBte2Wtsq10B0FVMqipdmD9GaeUsAlblp
	 BdcAwP1clQ+SB1+dk0iXLtj7K1Mvwi9ZLczLcclECN1Xxxbt6Kgsm+F0B6UbEfOOyG
	 kYvMYB4atCaT8vY7SZCVeQN+9NvO1NJZynmWbalFx0eNKqAsuu/gah8dkiPyi8BLj4
	 VzeamJKWv1oYc0CHYzfOYQ83OJlhYPB9RZ46/3cFCxojBYeNdcFupdqDJ4gsb8EBJo
	 yOaP3hPidWLqPyjbY3hObvm7y6ZyLlflEeLA428PoeFVp8AoaKQ+L55su05+C2VdZz
	 KoERpI9/dj/vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B689440636;
	Tue, 27 Oct 2026 08:46:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EBB54D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C7C80CF1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lz4pvF-0Zra8 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5E7480C0D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793090815;
 b=UrHTgkLzKqNDa72hEGv4CwUNFLAp0nand0/qVx5Yoo/kPLvZfsbf++vSznhGvH/3ooTH
 VBb2VIevdE42+z0mtPpgEWc6sCsbCosIYaPOnMV+s788e2FV/x6GYiqTdROIjXAGupVzC
 GaEzkT25tXRSmTfASgLWvQ9B9rWY6kA4/CxMzaUuIq1qOMnaCQHDLpS7Ca6VRDVAHY41M
 sEtpwh0l7Qt42g6tkDzU9+S96PzvHDrJQn/toklJy8eNehweTdVNDOe/aTe/teLXAp66E
 aFMvIPKmt1Hui6EXQSk33xSNtElriluGCA66p418+9t/oVVwMy5riYQ63Kn0doVIWMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793090815;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ZueCi67qHQ6H/avm/97LlmfUq4DN704TDAgJLt8cdqU=;
 b=c1Z9cESRoxeulqMEQTuAfcFMBe2WN6TvzxjFNpb910fKIMYqKvOn7fykP84eenl9EVVN
 tStDHV3TlMdPTbhKyJeJ09+VqUbinO7Z1rqxti+uZRDLtCKfndOMYD+wVNXnlQ6BPBn3b
 UBNLOJNR/ioZUnHLocEtdGMTH1ZkpOoni+poEMwNarzCzGruOZJgx2Gwlc7kc8kYj+nF8
 gl5fRPBSRR5jcL3BmIKI9P9wO3Vs/Lm4qXrTcoMiWZDYnKFCycxMkcA49owxkOd6PK5Rk
 wx6kVflLEGz3zHVp0FrtcjN2zrHfafUdbxC96XCGFrI16N+NNFpangmXVR6bzNh8g6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GhaxEHHY; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GhaxEHHY
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5E7480C0D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:46:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 565194399D;
 Tue, 27 Oct 2026 08:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71281F01829;
 Tue, 27 Oct 2026 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793090813;
 bh=ZueCi67qHQ6H/avm/97LlmfUq4DN704TDAgJLt8cdqU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=GhaxEHHYycnJh7DgNDNFVcpnJb/rn5Pv3nsqxGgSE81lWgleZALkJMWsMb4nOqJ+u
 riAZrMAUVGlxOh6lIgAbdnScY0FyCvYQk+txNPCaLrvNRrzoKwGHElnG0GVngsZhS6
 OvWKhP7s1763nWyTWk88xf7avvMLyrwZJ5aAG9VZPW8Syfkx7v3O+R2UU/mQihtdnM
 CsOn8apVdC7Z0P7Ax30e6U2kLLl0vuSZA6hk3Ap/22MUBsEw/PAa3iZdk+fj85Ljxz
 eO+3tIgOw17YRrR6fkovpO5j1url5i8DrerPZsTfkHiWa+8jokW0qJEsPbEDiZKwrT
 XLNaxZNpUkyvw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/14] usb: Add DWC2 HS OTG params for S5L87xx
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>, 
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>
In-Reply-To: <010701a17a6cb39d-93410dc3-89cb-402c-afa3-3e65d7c4d0ab-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
 <010701a17a6cb39d-93410dc3-89cb-402c-afa3-3e65d7c4d0ab-000000@eu-central-1.amazonses.com>
Date: Tue, 27 Oct 2026 09:46:48 +0100
Message-Id: <179309080834.259759.3060423921328394015.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=261;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Bl0QRdzdnLUCruhlqT6K7Gu0GS6Y/uGdt5jpag7S37U=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq4GT6eF351QIKGhfmnl/b3XUqGwzJcvrJFq1Nd
 IqZIlp4T5iJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCauBk+gAKCRAZDR20Zk4Z
 Nfh9B/90swsTClyDor6hLWr4pCq07CkBA4DKVhL33jrk0pjbOUbdGBYa/ChrTU9x9Ko+61VbvFe
 abVFyXB+JR1So0q+UkE+b68gAIJ5xLRhxCooVMF5+dLe7d8hLIAEA1TqSV9/3VMWZzjC0RX+hfm
 6sMvYOgpYg/awZvjdPoo/hQzFmmQ6f28brCbLZzyaYS9RWD1NLxcqvkNPz5ABHga2lL2vow/Zf5
 vCfmVsHrqUxA9TkYCCL4ldSa/TEJX52iQwbz65kmPlUyj0GSf7G3BZxwX2adqMGp9fmhJy/WLd+
 ky3frOJDQ1BQ2r0Hk+i0pJqhFa2VLDS23EwWNLOaVKX3/E+T
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 22:55:06 +0000, Vencislav Atanasov <user890104@freemyipod.org> wrote:
> The DWC2 core in S5L87xx needs a specific GUSBCFG.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
