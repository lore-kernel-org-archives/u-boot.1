Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC048606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BXN/7KUw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtB1wkFZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD4C6811F0;
	Tue, 17 Nov 2026 15:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGSoWIupXD2t; Tue, 17 Nov 2026 15:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC9A6811F6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927865;
	b=Fh51Mg6fWT1SLD9vsFEhV6aQLnl4+oV9/aTXU1EBfdReDCqaDx2fC6jSKC/2rmtUmpwO
	 e/EqHj9mzS1X1k2n/8r+EgBYqCZ61lmaIz0ajccur3y10v2z3YJVv1zZH6iMmMjLWrSxR
	 AA5QqlSHhwn0Dyk5Zk2ZyIsAzWaJ6zlKpeM+yuL1TolH710fsAJWLYGA3bHhuH+0p33iT
	 JDAdy9Lm9sAvn2VHtmIj8JoAHkf2hMYbpHzv2A0/ocJVOHRKLT2ABFAEoiu4WbmaoMckR
	 jDfbH4WDojU2R4CTrCgA3Ag8kcv8xFRrvfTIWd3PXS2PtF2i7zq4WByMt1B2tuLmb1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V1PwI3OLMFCGkVmH5PgO+Q584k/KUqWyvXNK1rDqFRg=;
	b=f6f8glM9QW2yIeC6oKeDx3akCN+BUcuY7EEz8853t8J0IkDcoRIkIVzOcJf2pH0RHAnY
	 f0vYBZKhvHg+oCgt0EMTXkN9tbzLmwxnQUlERQ1UujG5hafi88qcXNTU6U0moYM+9cX//
	 zH48n5/Ip3sr49apFPOYVpdda2x/u1zvkx8WpoNtiWEThLYfffuPEsg1vSmObBG3qtgzC
	 VJN8aiWQIdf2BfsOW0bG+ACi/VZbGgBFWamTOYYQ9V7xlYy1NYLdNCaTuVT6m98CokhDv
	 Lu2kZw/07TKV0AHB60hyORCXFCZWfoAYxwcTJGgTHGw79Zi69wRYs5XBlRYk7R7Qv5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927865;
	bh=V1PwI3OLMFCGkVmH5PgO+Q584k/KUqWyvXNK1rDqFRg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BXN/7KUwk8/PTy8t/F/4O3NrGIlFR3sPbKNDhRLxrNzjkTe0I+Nnj45yuduaDSXFs
	 eAqN3vT5xY8L4mBtCLIb+ecbIToqPukw9LSHeiuK9qTu5txb+KhOgZmdV0pKkdPF9s
	 n/HcNaaqfn03mZrql8TM1oUVu4nM/mO/HrcKVy9zZnl469UjwzlGiKRcHxOo+JlVHY
	 tVT7LrzAa8MjxcE3vro7FnrYVq9a73y/T9PSSwKK662RbRo10lja1s/wF2EpanuVBb
	 qVUuVsX/V+oimhw+xa/WHZrN8DrGpQxUmfekism9z+wOhnprpXF0EJX3L3PivJ1u3S
	 jKsZHdr6R5/0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC9A6811F6;
	Tue, 17 Nov 2026 15:04:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AE4A1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 315B3605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWBbEY2YhoQs for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81FEC605CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=mtB1wkFZ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81FEC605CB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CDBB63580;
 Tue, 17 Nov 2026 15:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943321F000C7;
 Tue, 17 Nov 2026 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927858;
 bh=V1PwI3OLMFCGkVmH5PgO+Q584k/KUqWyvXNK1rDqFRg=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=mtB1wkFZSTqvrlrQqzDikdaXTI1yQOR5VLFtpcKIW5VYW2VrXLECh8JiU97Fvp9sT
 OaS4j+/Gzl0nvDA7lJOaV9pDfyArA6LNqymbfQG10SvPkXFkCCepyS8Ca2vCDyn+2D
 cYjtyd8cLl/sHPSKXa8go/ctMIJH9vxIP3bL09uTLmJvjA7FR854XvqOa4QFE//uea
 G8ZSazf7oH7KusQIA7T7JlAKv3uqkmBO3rJbl/tIIOngRQb94ysAcj90a7jNt3rDXQ
 WoLHo4igwyfW/scWdwFGGIBy/o1pN6M69rlgCmVYyoh243cq+PH0QLqMYopU2CF+Fq
 qQW112ukdI35w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] usb: gadget: f_sdp: decode the command's address
 and count once
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
In-Reply-To: <86dbb40f-372d-4894-bdd2-b45f38b28e94@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <86dbb40f-372d-4894-bdd2-b45f38b28e94@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784366.252888.3891679373427769119.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=ilRkLyK/4V33I3TMnOkpHPt0XOveWEXcszpKW3F6WPc=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/GzomBl5JGUfPEqtJROt4gUzbUJIQU3bkxamt
 jVqjz9mtCuJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs6AAKCRAZDR20Zk4Z
 NXQpB/9O7VXLln/u1bzs2gPOTCc+ueGaVx5L0nO64VoyIoCq+O4dfxq5maNJBoqpyJP1FQiSQPH
 RgJsgYvtD3RCN4qVwFixRVbBbpoqYhA/9AQr0fvDtrSIQWQ6dDl2U0eEdSYiCPN1xMfeeIyBfeF
 fhnsr6MAKPp/aThrn0jBBnO7irlUlixW808/Iv2yaPAOfU5SEMknuv3A6F8mi5aOix7n5YDSnxp
 eHrYFXZG/XYaYxh2w+4Qs5u9WTxJw3H3bGug3Qp3y7+UD6aD1QWwN4/aaaAmseCqRQ1PxFWPo3x
 7vGZpN+jpg7bAyxwFRUajvUHpzU5ivq0dbOFdCQ9wxi2NES8
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 07:18:10 +0000, Ana Bobillo <anabobillo3@gmail.com> wrote:
> sdp_rx_command_complete() converts the big-endian addr and cnt fields
> of the command in each case that uses them. struct sdp_command is
> packed and starts one byte into the report, so every conversion is a
> run of byte loads: six of them across four commands.
> 
> Convert both fields once, before the switch. No functional change: an
> addr of zero still selects CONFIG_SDP_LOADADDR. This takes 96 bytes
> off the SPL of imx6dl_mamoj, room the closed-part checks later in this
> series need to stay within that board's SPL size limit.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
