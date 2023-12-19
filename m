Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845F5C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E930A86F42;
	Tue, 19 Dec 2023 21:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="imjMQ0T5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92EC68713C; Tue, 19 Dec 2023 21:08:52 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F67B86DB1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CC0C0A1756
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :content-id:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=mail; bh=4QjGRWj2ZkVgyfbaLUnBGOPUXtvlxy6k8R2VOE6AEos=; b=
 imjMQ0T5ezshXHPbhiQ8UeFzlISqckefz8SE3/Gdr+OPRciIJ2zbU7cLnYykYcHs
 GVhQ/c/NrIRlwmnZbU09esn/3YWzT9L8ESCDzaaJnlHvbW5S8myVWeSt8heRviRd
 2cMA2qqTpU8pQOyWd9PkFqDJGHiVi460MJ5MIeves8lYdByLtKcmO1UrFx3xPzCY
 eZj7fGKUetfZNQsrZLibaNUETzn/6qx9Tf8lOjd1GE00jq7HLx8CPkDtJfjiR1Hz
 sTGASfTUo9FA/1zi+e6wxc2mCURfsV3A4MSfd2WXG4VlKLu1BGeBIywPfs4uSPMQ
 5bdSfAt4BZ4coX9kI6xa9BMMrykYL352xDwcuz/3NTyXt8hhVyqVbfKr9RAbDCB5
 LtN2QDJHF4gXLiuKOcWCIIrKLnmf8rIZP69vcOwKTw0wNb/HhRF/skUh+pAF05gC
 9M4jWQpp/IY0vLUxWuQIrA1X0Qc0tQfnxxcnE+KO70botLYPGU3Z8WWSqoyr++tv
 GwT4OW2fNX04ir+id7SZ/Wf1S5Kl8NtUS+VCmJDz6LFW1pfooILF0+Yxr8J5FVxp
 trBVkUt0UbPf8uQ0Fmuwcd4IaMNls4LWZuEJh/uP3mFhFaLCXQVp4Sf4s7jkR4ZA
 hlmtls8mu50KGbZx08xeZcfT5OFrlOoUikMGOZWuPV8=
From: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
Subject: Passing boot logs to Linux?
Thread-Topic: Passing boot logs to Linux?
Thread-Index: AQHaMrctm4y2hROSMUG4p9BvonihzA==
Date: Tue, 19 Dec 2023 20:08:48 +0000
Message-ID: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.66.181.220]
x-esetresult: clean, is OK
x-esetid: 37303A29916D385C6D7C6A
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDA50B2CBE63E48AD1C62947533D9B3@prolan.hu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 19 Dec 2023 21:15:40 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

SGkhDQoNCklzIHBhc3NpbmcgdGhlIFUtQm9vdCBib290IGxvZyB0byBMaW51eCBzdXBwb3J0ZWQg
eWV0PyBXZSBhcmUgd29ya2luZyANCndpdGggYSB0aGlyZC1wYXJ0eSBzb2x1dGlvbiwgd2hpY2gg
d29ya3MsIGJ1dCBpcyBhIGJpdCBoYWNreSwgc28gSSB3YXMgDQp3b25kZXJpbmcgaWYgYW4gb2Zm
aWNpYWwgc29sdXRpb24gaGFzIGJlZW4gbWVyZ2VkIHlldC4NCg0KSSBzYXcgdGhhdCB0aGVyZSB3
YXMgYW4gb3B0aW9uIENPTkZJR19DT05TT0xFX1JFQ09SRCB0aGF0IHNhdmVzIA0KZXZlcnl0aGlu
ZyB0byBhIG1lbWJ1ZmYsIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhhdCBjYW4gYmUgZXhwb3J0ZWQg
dG8gDQpMaW51eCB5ZXQuIEFuZCBpZiBub3QgaW4gdGhlIHRyZWUgeWV0LCB3b3VsZCBzdWNoIGEg
cGF0Y2ggYmUgd2VsY29tZT8NCg0KQmVuY2UNCg0K

