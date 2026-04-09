Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD5CEA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6228484222;
	Thu,  9 Apr 2026 15:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXXTlNae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43A183D8A; Thu,  9 Apr 2026 06:57:13 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61C683693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 06:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebasjosue84@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c280322e0so48613366b.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 21:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775710631; cv=none;
 d=google.com; s=arc-20240605;
 b=DojZXAe7lvLfvByMilJctAqu6M+dbPb07NzCslIEL0HmS0/5byxUCvlwSVLtufJ0gn
 eJh7Iirv1OF2y+KogvwwRENbc5m+WbO1AJcp1xXMJ9DfZ9QwMDJmZEaVLvDPN28wRWfw
 mHEJiJ0FDray9E6/Zl9lFO+rO9S4czv8x+ewxrjjn6EUhICyeBLYofp++bzQzFfazzZJ
 L+KHRowRCXOqurPqNXqnxfeNP/0BkaxuevEb2AtGY19UcPgxiomDYgOApF7mCKgIJ+hB
 2pFzIkgqQZssEdW7tkCyV2thIxw3hRfy3iXVWNEhDNRnq83rtuJMQ96HBzECz1QKMBYD
 sGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=jEmAU1mLzjCOh8JZL1ewmYRCa2qiac9Zp+6KTMC1J8g=;
 fh=IOyNx+LNBCeQaTbjFkJSK2yHvu/RFwlvG70nK7N1keM=;
 b=BdP06ZNYB2ZDDqzUpry+qG19jc9z6hhtXKlTsJGd9RTXQ5aDGhUJKNBegFkK70KCW+
 7Gj2bEJ9FrjxLY1c9GfhqiCrPUIv3Woa9yovq0ns1fuwLYyK3EyYhThFSgWp7GZilIaq
 JgZMZbCbOLD5nZSozKPyobdCEi/9ob12kZa5q7faA6uf3X8tq86t3aeg7VCsk6kCeLNj
 SMM/LsOu/bgeuTDgSv/3Xxn6IaPhrjTed65V2JJyk4ak5nd9WJ+tOFkAGz8eFXmEwQ0Z
 2fsy8Ub5+2zMQYG0cHVvCZr3QcykDzZMgyGjvHInKLCalv5iC4/17jfVzH9r9dJ3MPbQ
 0CzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775710631; x=1776315431; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jEmAU1mLzjCOh8JZL1ewmYRCa2qiac9Zp+6KTMC1J8g=;
 b=bXXTlNae6HS++zx4nkEr4QbyW38CbKdqQAsizhH3b5qbKKtaw2PXRrVL2lN2xLkNHK
 johjJmsNJxGsvXbtdC5TqEpe3Jm2e1yGjBZYiMl6qiCud2mq+NztY4NUtOgsU0FS6cHh
 rCMbIDQn3UUEt3Je/FN9ywXvN5fxSlh4Fr4aq+/9/KMBJLn1FlTa7VdLDK4ZPQjNIf3I
 7n9YdKqar7jUvWqXGH6fQvXPqL0zLRz8nLnS7/AL8bQg3nNWGiFrzZ9NYz8x5cyEx5Xb
 1B7/M8/3kA90oOMOvY4ddassZWcMpAc2J2GkG4HWYhtXJplwzskHzFoDrfZDWI80MQxf
 Kg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775710631; x=1776315431;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jEmAU1mLzjCOh8JZL1ewmYRCa2qiac9Zp+6KTMC1J8g=;
 b=KUr+v7lxf3JVpSAbue+UH9eOMLSBJTi9C5+JtLtHDU4RmyZYTJBrrsZ83OLnMce5QA
 rn/pC4YTWVihXYytDlML52sJnw3c6q/KxZiNf75b5LbB9+5jhduFtS69lyeJ+q13yxmL
 dshkstldrS+GwY/WOXvjSPKi/cX6BMIeV8sXMzWdxt90ZRDUeloS4teKhgcGgk3ob7BH
 pEWN7j8/QyuEZ5FjZLomdJOeu3G81T/CoTx6Y1bN9bS+z7t+eahjli9qFQgOy03jS9G/
 7IrTqg6fJYgZg7fTiDbPBuX1vVwsPOxsBjqUzEZArcA03hiaRG9fXRdIGQLT0Gxif3B/
 uUbg==
X-Gm-Message-State: AOJu0YyPdGLu81/xZKoN0TvkL1PBTmszngdv3q3761KKki0dEm5hMlsG
 WO3bpsfBh5yDjLa1xY2fJrTOY2Dcsa+E8jx1jAkr0NbK8BFrhPis08KGHtawwQpO2HgXL0v766E
 PO6uCAxvFzVcfiWfIRBw0+YqkQ/f/q2xe4imkf4c=
X-Gm-Gg: AeBDieseR+i5g2RUme8mbOglFPA2PqKoumPSIqQsSZc4UJQ3EAIkhIJaF3Tw8vcruka
 3MgJRN+AURL8GPyMfMggpz/MpRyqhPdPMa8jQ9yeawzjvFqhJ4mdrhVZsRWS3lbCtW7eq9BIWGJ
 DVMLTirAmi6zNlV5v/4CJGcp4zvlAHqIp2EKzJ3BPvN7Mty95iRVB/VE/x/EPAXC0JFWuFMrQ2/
 z6OP+um+P+K74RvmjjP+UgteAw8BcShN0l5UYipvpTgW3MfBrQ+DcBvcSDk0xKsdqVwJZ53PVt1
 SP++ewTb
X-Received: by 2002:a17:907:1c23:b0:b9c:2c55:338c with SMTP id
 a640c23a62f3a-b9c677fbd02mr1148035966b.25.1775710630738; Wed, 08 Apr 2026
 21:57:10 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Wed, 8 Apr 2026 22:56:59 -0600
X-Gm-Features: AQROBzCnfmjklzDEjiDFcXCfa_XwcMvWFPDz-fEwyiBsr9vdQ5cnDwHkx-bmkfI
Message-ID: <CAJD=UNd17V=anGd6C=jM8YzV10uTwEewae+CD1YGym5=JGeuiw@mail.gmail.com>
Subject: [SECURITY] net: nfs: buffer overflow in nfs_readlink_reply() in
 legacy NFS path (nfs-common.c) , incomplete fix
To: u-boot@lists.denx.de, jerome.forissier@arm.com, trini@konsulko.com
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jerome, Tom, and U-Boot security list,

I would like to report a buffer overflow vulnerability in
net/nfs-common.c:nfs_readlink_reply()
that was not addressed by the recent fix in commit fd6e3d34097f ("net:
lwip: nfs: fix buffer
overflow when using symlinks").


*=3D=3D Vulnerability =3D=3D*
File: net/nfs-common.c | Function: nfs_readlink_reply() | Lines: ~667-685

The `rlen` field from a server READLINK reply is validated only against the
incoming packet
length (check inherited from CVE-2019-14195), but NOT against the
destination buffer
nfs_path_buff[2048]:

    rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);

    /* validates rlen against packet size only */
    if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)(&rpc_pkt) + rlen) >
len)
        return -NFS_RPC_DROP;

    /* MISSING: check that pathlen + rlen < sizeof(nfs_path_buff) */
    pathlen =3D strlen(nfs_path);
    memcpy(nfs_path + pathlen, data, rlen);   /* BSS overflow */
    nfs_path[pathlen + rlen] =3D 0;             /* OOB write */

An attacker controlling an NFS server can send a syntactically valid
READLINK reply
(rlen <=3D packet_size) where pathlen + rlen exceeds sizeof(nfs_path_buff) =
=3D
2048,
overflowing the BSS buffer into adjacent memory.


*=3D=3D Relationship to Existing Fixes =3D=3D*
- CVE-2019-14195 (cf3a4f1e86): added a packet-size check for rlen only =E2=
=80=94
does not bound the copy against nfs_path_buff.
- fd6e3d34097f ("net: lwip: nfs: fix buffer overflow when using symlinks"):
fixed the same overflow class in net/lwip/nfs.c only; net/nfs-common.c
(legacy NFS path) was not addressed.


*=3D=3D Impact =3D=3D*
CWE-120 | CVSS 8.8 (AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H)
Affects any U-Boot client booting via NFS when symlinks are present on the
server.


*=3D=3D Suggested Fix =3D=3D*
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
     pathlen =3D strlen(nfs_path);
+    if (pathlen + rlen >=3D sizeof(nfs_path_buff))
+        return -NFS_RPC_DROP;
     memcpy(nfs_path + pathlen, data, rlen);
     nfs_path[pathlen + rlen] =3D 0;

Also required for the absolute path branch (~L683):
+    if (rlen >=3D sizeof(nfs_path_buff))
+        return -NFS_RPC_DROP;
     memcpy(nfs_path, data, rlen);
     nfs_path[rlen] =3D 0;



I would appreciate if the project could request a CVE identifier through
the appropriate CNA, crediting me as the reporter.



Regards,
Sebasti=C3=A1n Alba Vives (@Sebasteuo)


--
